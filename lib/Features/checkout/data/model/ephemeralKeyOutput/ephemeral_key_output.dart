import 'package:equatable/equatable.dart';

import 'associated_object.dart';

class EphemeralKeyOutput extends Equatable {
  final String? id;
  final String? object;
  final List<AssociatedObject>? associatedObjects;
  final int? created;
  final int? expires;
  final bool? liveMode;
  final String? secret;

  const EphemeralKeyOutput({
    this.id,
    this.object,
    this.associatedObjects,
    this.created,
    this.expires,
    this.liveMode,
    this.secret,
  });

  factory EphemeralKeyOutput.fromJson(Map<String, dynamic> json) {
    return EphemeralKeyOutput(
      id: json['id'] as String?,
      object: json['object'] as String?,
      associatedObjects: (json['associated_objects'] as List<dynamic>?)
          ?.map((e) => AssociatedObject.fromJson(e as Map<String, dynamic>))
          .toList(),
      created: json['created'] as int?,
      expires: json['expires'] as int?,
      liveMode: json['livemode'] as bool?,
      secret: json['secret'] as String?,
    );
  }

  Map<String, dynamic> toJson() => {
        'id': id,
        'object': object,
        'associated_objects':
            associatedObjects?.map((e) => e.toJson()).toList(),
        'created': created,
        'expires': expires,
        'livemode': liveMode,
        'secret': secret,
      };

  @override
  List<Object?> get props {
    return [
      id,
      object,
      associatedObjects,
      created,
      expires,
      liveMode,
      secret,
    ];
  }
}
