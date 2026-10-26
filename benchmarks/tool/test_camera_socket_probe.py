"""Pure stdlib checks for the passive /proc camera observer; no sockets or device."""

import unittest

import camera_socket_probe as probe


def config(*screens):
    return {'slideshow': {'specialScreens': list(screens)}}


def cameras(*sources):
    return {'type': 'cameras', 'options': {'cameras': list(sources)}}


def tcp_text(*rows):
    header = 'sl local_address rem_address st tx_queue rx_queue tr tm->when retrnsmt uid timeout inode\n'
    return header + ''.join(
        f'{index}: 0100007F:AAAA {address}:{port:04X} {state} '
        f'00000000:00000000 00:00000000 00000000 1000 0 {inode} 1\n'
        for index, (address, port, state, inode) in enumerate(rows)
    )


class CameraEndpointsTest(unittest.TestCase):
    def test_same_ipv4_and_port_groups_paths_and_credentials(self):
        result = probe.camera_endpoints(config(cameras(
            {'url': 'http://user:secret@192.168.1.10/snapshot?token=private'},
            {'url': 'http://192.168.1.10:80/different.png'},
        )))
        self.assertEqual(result, {('0A01A8C0', 80): [0, 1]})

    def test_ports_and_default_https_remain_distinct(self):
        result = probe.camera_endpoints(config(cameras(
            {'url': 'http://192.168.1.10/snapshot'},
            {'url': 'http://192.168.1.10:8080/snapshot'},
            {'url': 'https://192.168.1.10/snapshot'},
            {'url': 'https://192.168.1.10:8080/other'},
        )))
        self.assertEqual(result, {
            ('0A01A8C0', 80): [0],
            ('0A01A8C0', 8080): [1, 3],
            ('0A01A8C0', 443): [2],
        })

    def test_skipped_sources_preserve_indices_across_camera_screens(self):
        result = probe.camera_endpoints(config(
            {'type': 'clock', 'options': {'cameras': [{'url': 'http://192.168.1.99'}]}},
            cameras(
                {'url': 'http://camera.local/snapshot'},
                {'url': 'http://[::1]/snapshot'},
                {'url': 'rtsp://192.168.1.10/stream'},
                {},
                {'url': 'http://192.168.1.10:invalid/snapshot'},
                {'url': 'http://192.168.1.10/snapshot'},
            ),
            {'type': 'clock'},
            cameras({'url': 'http://192.168.1.10/other'}),
        ))
        self.assertEqual(result, {('0A01A8C0', 80): [5, 6]})

    def test_missing_configuration_has_no_endpoints(self):
        self.assertEqual(probe.camera_endpoints({}), {})
        self.assertEqual(probe.camera_endpoints(config({'type': 'cameras'})), {})


class TcpStatesTest(unittest.TestCase):
    def test_duplicate_camera_endpoint_states_are_grouped_and_counted(self):
        text = tcp_text(
            ('0A01A8C0', 80, '01', 101),
            ('0A01A8C0', 80, '01', 102),
            ('0A01A8C0', 80, '02', 103),
            ('0A01A8C0', 8080, '08', 104),
        )
        owned = {f'socket:[{inode}]' for inode in range(101, 105)}
        states, mqtt = probe.tcp_states(text, owned, {
            ('0A01A8C0', 80): [0, 2],
            ('0A01A8C0', 8080): [3],
        })
        self.assertEqual(states, {'0,2:01': 2, '0,2:02': 1, '3:08': 1})
        self.assertEqual(mqtt, {})

    def test_unowned_and_unmatched_sockets_are_excluded(self):
        text = tcp_text(
            ('0A01A8C0', 80, '01', 201),
            ('0A01A8C0', 80, '02', 202),
            ('0A01A8C0', 8080, '08', 203),
            ('0A01A8C0', 1883, '01', 204),
        )
        states, mqtt = probe.tcp_states(text, {'socket:[201]', 'socket:[203]', 'file'}, {
            ('0A01A8C0', 80): [1],
        })
        self.assertEqual(states, {'1:01': 1})
        self.assertEqual(mqtt, {})

    def test_mqtt_1883_is_distinct_from_camera_ports_on_same_host(self):
        text = tcp_text(
            ('0A01A8C0', 80, '01', 301),
            ('0A01A8C0', 1883, '01', 302),
            ('0B01A8C0', 1883, '08', 303),
            ('0A01A8C0', 1884, '02', 304),
        )
        owned = {f'socket:[{inode}]' for inode in range(301, 305)}
        states, mqtt = probe.tcp_states(text, owned, {('0A01A8C0', 80): [4]})
        self.assertEqual(states, {'4:01': 1})
        self.assertEqual(mqtt, {'01': 1, '08': 1})

    def test_header_without_rows_has_empty_counts(self):
        self.assertEqual(probe.tcp_states(tcp_text(), set(), {}), ({}, {}))


if __name__ == '__main__':
    unittest.main()
