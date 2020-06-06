/**
 * Módulo para generar pines y conectores.
 *
 * @author  Joaquín Fernández
 * @url     https://gitlab.com/joaquinfq/openscad/blob/master/Modules/Models/PCB/pin.scad
 * @license CC-BY-NC-4.0
 */

/**
 * Genera un pin de un conector.
 *
 * @param {Float} length Longitud del pin (eje Z).
 */
module pcbPin(length = 0)
{
    _s = 2.54;
    _t = 2.3;
    _l = length
        ? length
        : 6.75 + _t + _s;
    color([ 0.2, 0.2, 0.2 ])
    {
        intersection()
        {
            rotate([ 0, 0, 45 ])
            {
                cylinder(d = norm([ 2.54, 2.54 ]), h = _t, center = true, $fn = 4);
            }
            cylinder(d = norm([ 3, 3 ]), h = _t, center = true, $fn = 4);
        }
    }
    color("gold")
    {
        rotate([ 0, 0, 45 ])
        {
            translate([ 0, 0, _l / 2 - _t / 2 - _s ])
            {
                cylinder(d = 0.66, h = _l, center = true, $fn = 4);
                for (z = [ -1, 1 ])
                {
                    translate([ 0, 0, z * (_l / 2 + 0.38) ])
                    {
                        rotate([ 90 * (z - 1), 0, 0 ])
                        {
                            cylinder(d1 = 0.66, d2 = 0.28, h = 0.76, center = true, $fn = 4);
                        }
                    }
                }
            }
        }
    }
}
/**
 * Módulo que genera un conector.
 *
 * @param {Float} rows    Cantidad de filas de pines (eje X).
 * @param {Float} columns Cantidad de columnas de pines (eje Y).
 * @param {Float} length  Longitud del pin (eje Z).
 */
module pcbPinConnector(rows = 2, columns = 20, length = 0)
{
    translate([ 2.54 / 2, 2.54 / 2, 2.3 / 2 ])
    {
        for (_x = [ 0 : rows - 1 ])
        {
            for (_y = [ 0 : columns - 1 ])
            {
                translate([ _x * 2.54, _y * 2.54, 0 ])
                {
                    pcbPin(length);
                }
            }
        }
    }
}
