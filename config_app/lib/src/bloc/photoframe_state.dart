import 'package:dslideshow_backend/config.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

@immutable
class PhotoframeState extends Equatable {
  late AppConfig config;

  PhotoframeState._({AppConfig? config}) {
    if (config == null) {
      this.config = AppConfig.fromJson(const {});
    } else {
      this.config = config;
    }
  }
/*
  const AuthenticationState.unknown() : this._();

  const AuthenticationState.authenticated(User user) : this._(status: AuthenticationStatus.authenticated, user: user);

  const AuthenticationState.unauthenticated() : this._(status: AuthenticationStatus.unauthenticated);

  final AuthenticationStatus status;
  final User user;
*/
  @override
  List<Object> get props => [config];
}
