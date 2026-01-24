// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'account.dart';

// **************************************************************************
// IsarCollectionGenerator
// **************************************************************************

// coverage:ignore-file
// ignore_for_file: duplicate_ignore, non_constant_identifier_names, constant_identifier_names, invalid_use_of_protected_member, unnecessary_cast, prefer_const_constructors, lines_longer_than_80_chars, require_trailing_commas, inference_failure_on_function_invocation, unnecessary_parenthesis, unnecessary_raw_strings, unnecessary_null_checks, join_return_with_assignment, prefer_final_locals, avoid_js_rounded_ints, avoid_positional_boolean_parameters, always_specify_types

extension GetAccountCollection on Isar {
  IsarCollection<Account> get accounts => this.collection();
}

const AccountSchema = CollectionSchema(
  name: r'Account',
  id: -6646797162501847804,
  properties: {
    r'accessToken': PropertySchema(
      id: 0,
      name: r'accessToken',
      type: IsarType.string,
    ),
    r'additionalData': PropertySchema(
      id: 1,
      name: r'additionalData',
      type: IsarType.string,
    ),
    r'apiKey': PropertySchema(id: 2, name: r'apiKey', type: IsarType.string),
    r'avatarUrl': PropertySchema(
      id: 3,
      name: r'avatarUrl',
      type: IsarType.string,
    ),
    r'bindTime': PropertySchema(
      id: 4,
      name: r'bindTime',
      type: IsarType.dateTime,
    ),
    r'credentialCreatedAt': PropertySchema(
      id: 5,
      name: r'credentialCreatedAt',
      type: IsarType.dateTime,
    ),
    r'credentialType': PropertySchema(
      id: 6,
      name: r'credentialType',
      type: IsarType.string,
      enumMap: _AccountcredentialTypeEnumValueMap,
    ),
    r'credentialUpdatedAt': PropertySchema(
      id: 7,
      name: r'credentialUpdatedAt',
      type: IsarType.dateTime,
    ),
    r'displayName': PropertySchema(
      id: 8,
      name: r'displayName',
      type: IsarType.string,
    ),
    r'externalId': PropertySchema(
      id: 9,
      name: r'externalId',
      type: IsarType.string,
    ),
    r'isActive': PropertySchema(id: 10, name: r'isActive', type: IsarType.bool),
    r'isTokenExpired': PropertySchema(
      id: 11,
      name: r'isTokenExpired',
      type: IsarType.bool,
    ),
    r'isTokenExpiringSoon': PropertySchema(
      id: 12,
      name: r'isTokenExpiringSoon',
      type: IsarType.bool,
    ),
    r'lastSyncTime': PropertySchema(
      id: 13,
      name: r'lastSyncTime',
      type: IsarType.dateTime,
    ),
    r'metadata': PropertySchema(
      id: 14,
      name: r'metadata',
      type: IsarType.string,
    ),
    r'password': PropertySchema(
      id: 15,
      name: r'password',
      type: IsarType.string,
    ),
    r'platform': PropertySchema(
      id: 16,
      name: r'platform',
      type: IsarType.string,
      enumMap: _AccountplatformEnumValueMap,
    ),
    r'refreshToken': PropertySchema(
      id: 17,
      name: r'refreshToken',
      type: IsarType.string,
    ),
    r'tokenExpiry': PropertySchema(
      id: 18,
      name: r'tokenExpiry',
      type: IsarType.dateTime,
    ),
    r'username': PropertySchema(
      id: 19,
      name: r'username',
      type: IsarType.string,
    ),
  },

  estimateSize: _accountEstimateSize,
  serialize: _accountSerialize,
  deserialize: _accountDeserialize,
  deserializeProp: _accountDeserializeProp,
  idName: r'id',
  indexes: {
    r'externalId_platform': IndexSchema(
      id: -913971142753160343,
      name: r'externalId_platform',
      unique: true,
      replace: false,
      properties: [
        IndexPropertySchema(
          name: r'externalId',
          type: IndexType.hash,
          caseSensitive: true,
        ),
        IndexPropertySchema(
          name: r'platform',
          type: IndexType.hash,
          caseSensitive: true,
        ),
      ],
    ),
  },
  links: {},
  embeddedSchemas: {},

  getId: _accountGetId,
  getLinks: _accountGetLinks,
  attach: _accountAttach,
  version: '3.3.0',
);

int _accountEstimateSize(
  Account object,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  var bytesCount = offsets.last;
  {
    final value = object.accessToken;
    if (value != null) {
      bytesCount += 3 + value.length * 3;
    }
  }
  {
    final value = object.additionalData;
    if (value != null) {
      bytesCount += 3 + value.length * 3;
    }
  }
  {
    final value = object.apiKey;
    if (value != null) {
      bytesCount += 3 + value.length * 3;
    }
  }
  {
    final value = object.avatarUrl;
    if (value != null) {
      bytesCount += 3 + value.length * 3;
    }
  }
  bytesCount += 3 + object.credentialType.name.length * 3;
  {
    final value = object.displayName;
    if (value != null) {
      bytesCount += 3 + value.length * 3;
    }
  }
  bytesCount += 3 + object.externalId.length * 3;
  {
    final value = object.metadata;
    if (value != null) {
      bytesCount += 3 + value.length * 3;
    }
  }
  {
    final value = object.password;
    if (value != null) {
      bytesCount += 3 + value.length * 3;
    }
  }
  bytesCount += 3 + object.platform.name.length * 3;
  {
    final value = object.refreshToken;
    if (value != null) {
      bytesCount += 3 + value.length * 3;
    }
  }
  {
    final value = object.username;
    if (value != null) {
      bytesCount += 3 + value.length * 3;
    }
  }
  return bytesCount;
}

void _accountSerialize(
  Account object,
  IsarWriter writer,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  writer.writeString(offsets[0], object.accessToken);
  writer.writeString(offsets[1], object.additionalData);
  writer.writeString(offsets[2], object.apiKey);
  writer.writeString(offsets[3], object.avatarUrl);
  writer.writeDateTime(offsets[4], object.bindTime);
  writer.writeDateTime(offsets[5], object.credentialCreatedAt);
  writer.writeString(offsets[6], object.credentialType.name);
  writer.writeDateTime(offsets[7], object.credentialUpdatedAt);
  writer.writeString(offsets[8], object.displayName);
  writer.writeString(offsets[9], object.externalId);
  writer.writeBool(offsets[10], object.isActive);
  writer.writeBool(offsets[11], object.isTokenExpired);
  writer.writeBool(offsets[12], object.isTokenExpiringSoon);
  writer.writeDateTime(offsets[13], object.lastSyncTime);
  writer.writeString(offsets[14], object.metadata);
  writer.writeString(offsets[15], object.password);
  writer.writeString(offsets[16], object.platform.name);
  writer.writeString(offsets[17], object.refreshToken);
  writer.writeDateTime(offsets[18], object.tokenExpiry);
  writer.writeString(offsets[19], object.username);
}

Account _accountDeserialize(
  Id id,
  IsarReader reader,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  final object = Account(
    accessToken: reader.readStringOrNull(offsets[0]),
    additionalData: reader.readStringOrNull(offsets[1]),
    apiKey: reader.readStringOrNull(offsets[2]),
    avatarUrl: reader.readStringOrNull(offsets[3]),
    bindTime: reader.readDateTimeOrNull(offsets[4]),
    credentialCreatedAt: reader.readDateTimeOrNull(offsets[5]),
    credentialType:
        _AccountcredentialTypeValueEnumMap[reader.readStringOrNull(
          offsets[6],
        )] ??
        CredentialType.apiKey,
    credentialUpdatedAt: reader.readDateTimeOrNull(offsets[7]),
    displayName: reader.readStringOrNull(offsets[8]),
    externalId: reader.readString(offsets[9]),
    id: id,
    isActive: reader.readBoolOrNull(offsets[10]) ?? true,
    lastSyncTime: reader.readDateTimeOrNull(offsets[13]),
    metadata: reader.readStringOrNull(offsets[14]),
    password: reader.readStringOrNull(offsets[15]),
    platform:
        _AccountplatformValueEnumMap[reader.readStringOrNull(offsets[16])] ??
        Platform.divingFish,
    refreshToken: reader.readStringOrNull(offsets[17]),
    tokenExpiry: reader.readDateTimeOrNull(offsets[18]),
    username: reader.readStringOrNull(offsets[19]),
  );
  return object;
}

P _accountDeserializeProp<P>(
  IsarReader reader,
  int propertyId,
  int offset,
  Map<Type, List<int>> allOffsets,
) {
  switch (propertyId) {
    case 0:
      return (reader.readStringOrNull(offset)) as P;
    case 1:
      return (reader.readStringOrNull(offset)) as P;
    case 2:
      return (reader.readStringOrNull(offset)) as P;
    case 3:
      return (reader.readStringOrNull(offset)) as P;
    case 4:
      return (reader.readDateTimeOrNull(offset)) as P;
    case 5:
      return (reader.readDateTimeOrNull(offset)) as P;
    case 6:
      return (_AccountcredentialTypeValueEnumMap[reader.readStringOrNull(
                offset,
              )] ??
              CredentialType.apiKey)
          as P;
    case 7:
      return (reader.readDateTimeOrNull(offset)) as P;
    case 8:
      return (reader.readStringOrNull(offset)) as P;
    case 9:
      return (reader.readString(offset)) as P;
    case 10:
      return (reader.readBoolOrNull(offset) ?? true) as P;
    case 11:
      return (reader.readBool(offset)) as P;
    case 12:
      return (reader.readBool(offset)) as P;
    case 13:
      return (reader.readDateTimeOrNull(offset)) as P;
    case 14:
      return (reader.readStringOrNull(offset)) as P;
    case 15:
      return (reader.readStringOrNull(offset)) as P;
    case 16:
      return (_AccountplatformValueEnumMap[reader.readStringOrNull(offset)] ??
              Platform.divingFish)
          as P;
    case 17:
      return (reader.readStringOrNull(offset)) as P;
    case 18:
      return (reader.readDateTimeOrNull(offset)) as P;
    case 19:
      return (reader.readStringOrNull(offset)) as P;
    default:
      throw IsarError('Unknown property with id $propertyId');
  }
}

const _AccountcredentialTypeEnumValueMap = {
  r'apiKey': r'apiKey',
  r'oauth2': r'oauth2',
  r'userPassword': r'userPassword',
  r'custom': r'custom',
};
const _AccountcredentialTypeValueEnumMap = {
  r'apiKey': CredentialType.apiKey,
  r'oauth2': CredentialType.oauth2,
  r'userPassword': CredentialType.userPassword,
  r'custom': CredentialType.custom,
};
const _AccountplatformEnumValueMap = {
  r'divingFish': r'divingFish',
  r'lxns': r'lxns',
  r'developerFish': r'developerFish',
  r'custom': r'custom',
};
const _AccountplatformValueEnumMap = {
  r'divingFish': Platform.divingFish,
  r'lxns': Platform.lxns,
  r'developerFish': Platform.developerFish,
  r'custom': Platform.custom,
};

Id _accountGetId(Account object) {
  return object.id;
}

List<IsarLinkBase<dynamic>> _accountGetLinks(Account object) {
  return [];
}

void _accountAttach(IsarCollection<dynamic> col, Id id, Account object) {
  object.id = id;
}

extension AccountByIndex on IsarCollection<Account> {
  Future<Account?> getByExternalIdPlatform(
    String externalId,
    Platform platform,
  ) {
    return getByIndex(r'externalId_platform', [externalId, platform]);
  }

  Account? getByExternalIdPlatformSync(String externalId, Platform platform) {
    return getByIndexSync(r'externalId_platform', [externalId, platform]);
  }

  Future<bool> deleteByExternalIdPlatform(
    String externalId,
    Platform platform,
  ) {
    return deleteByIndex(r'externalId_platform', [externalId, platform]);
  }

  bool deleteByExternalIdPlatformSync(String externalId, Platform platform) {
    return deleteByIndexSync(r'externalId_platform', [externalId, platform]);
  }

  Future<List<Account?>> getAllByExternalIdPlatform(
    List<String> externalIdValues,
    List<Platform> platformValues,
  ) {
    final len = externalIdValues.length;
    assert(
      platformValues.length == len,
      'All index values must have the same length',
    );
    final values = <List<dynamic>>[];
    for (var i = 0; i < len; i++) {
      values.add([externalIdValues[i], platformValues[i]]);
    }

    return getAllByIndex(r'externalId_platform', values);
  }

  List<Account?> getAllByExternalIdPlatformSync(
    List<String> externalIdValues,
    List<Platform> platformValues,
  ) {
    final len = externalIdValues.length;
    assert(
      platformValues.length == len,
      'All index values must have the same length',
    );
    final values = <List<dynamic>>[];
    for (var i = 0; i < len; i++) {
      values.add([externalIdValues[i], platformValues[i]]);
    }

    return getAllByIndexSync(r'externalId_platform', values);
  }

  Future<int> deleteAllByExternalIdPlatform(
    List<String> externalIdValues,
    List<Platform> platformValues,
  ) {
    final len = externalIdValues.length;
    assert(
      platformValues.length == len,
      'All index values must have the same length',
    );
    final values = <List<dynamic>>[];
    for (var i = 0; i < len; i++) {
      values.add([externalIdValues[i], platformValues[i]]);
    }

    return deleteAllByIndex(r'externalId_platform', values);
  }

  int deleteAllByExternalIdPlatformSync(
    List<String> externalIdValues,
    List<Platform> platformValues,
  ) {
    final len = externalIdValues.length;
    assert(
      platformValues.length == len,
      'All index values must have the same length',
    );
    final values = <List<dynamic>>[];
    for (var i = 0; i < len; i++) {
      values.add([externalIdValues[i], platformValues[i]]);
    }

    return deleteAllByIndexSync(r'externalId_platform', values);
  }

  Future<Id> putByExternalIdPlatform(Account object) {
    return putByIndex(r'externalId_platform', object);
  }

  Id putByExternalIdPlatformSync(Account object, {bool saveLinks = true}) {
    return putByIndexSync(r'externalId_platform', object, saveLinks: saveLinks);
  }

  Future<List<Id>> putAllByExternalIdPlatform(List<Account> objects) {
    return putAllByIndex(r'externalId_platform', objects);
  }

  List<Id> putAllByExternalIdPlatformSync(
    List<Account> objects, {
    bool saveLinks = true,
  }) {
    return putAllByIndexSync(
      r'externalId_platform',
      objects,
      saveLinks: saveLinks,
    );
  }
}

extension AccountQueryWhereSort on QueryBuilder<Account, Account, QWhere> {
  QueryBuilder<Account, Account, QAfterWhere> anyId() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(const IdWhereClause.any());
    });
  }
}

extension AccountQueryWhere on QueryBuilder<Account, Account, QWhereClause> {
  QueryBuilder<Account, Account, QAfterWhereClause> idEqualTo(Id id) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IdWhereClause.between(lower: id, upper: id));
    });
  }

  QueryBuilder<Account, Account, QAfterWhereClause> idNotEqualTo(Id id) {
    return QueryBuilder.apply(this, (query) {
      if (query.whereSort == Sort.asc) {
        return query
            .addWhereClause(
              IdWhereClause.lessThan(upper: id, includeUpper: false),
            )
            .addWhereClause(
              IdWhereClause.greaterThan(lower: id, includeLower: false),
            );
      } else {
        return query
            .addWhereClause(
              IdWhereClause.greaterThan(lower: id, includeLower: false),
            )
            .addWhereClause(
              IdWhereClause.lessThan(upper: id, includeUpper: false),
            );
      }
    });
  }

  QueryBuilder<Account, Account, QAfterWhereClause> idGreaterThan(
    Id id, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.greaterThan(lower: id, includeLower: include),
      );
    });
  }

  QueryBuilder<Account, Account, QAfterWhereClause> idLessThan(
    Id id, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.lessThan(upper: id, includeUpper: include),
      );
    });
  }

  QueryBuilder<Account, Account, QAfterWhereClause> idBetween(
    Id lowerId,
    Id upperId, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.between(
          lower: lowerId,
          includeLower: includeLower,
          upper: upperId,
          includeUpper: includeUpper,
        ),
      );
    });
  }

  QueryBuilder<Account, Account, QAfterWhereClause>
  externalIdEqualToAnyPlatform(String externalId) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IndexWhereClause.equalTo(
          indexName: r'externalId_platform',
          value: [externalId],
        ),
      );
    });
  }

  QueryBuilder<Account, Account, QAfterWhereClause>
  externalIdNotEqualToAnyPlatform(String externalId) {
    return QueryBuilder.apply(this, (query) {
      if (query.whereSort == Sort.asc) {
        return query
            .addWhereClause(
              IndexWhereClause.between(
                indexName: r'externalId_platform',
                lower: [],
                upper: [externalId],
                includeUpper: false,
              ),
            )
            .addWhereClause(
              IndexWhereClause.between(
                indexName: r'externalId_platform',
                lower: [externalId],
                includeLower: false,
                upper: [],
              ),
            );
      } else {
        return query
            .addWhereClause(
              IndexWhereClause.between(
                indexName: r'externalId_platform',
                lower: [externalId],
                includeLower: false,
                upper: [],
              ),
            )
            .addWhereClause(
              IndexWhereClause.between(
                indexName: r'externalId_platform',
                lower: [],
                upper: [externalId],
                includeUpper: false,
              ),
            );
      }
    });
  }

  QueryBuilder<Account, Account, QAfterWhereClause> externalIdPlatformEqualTo(
    String externalId,
    Platform platform,
  ) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IndexWhereClause.equalTo(
          indexName: r'externalId_platform',
          value: [externalId, platform],
        ),
      );
    });
  }

  QueryBuilder<Account, Account, QAfterWhereClause>
  externalIdEqualToPlatformNotEqualTo(String externalId, Platform platform) {
    return QueryBuilder.apply(this, (query) {
      if (query.whereSort == Sort.asc) {
        return query
            .addWhereClause(
              IndexWhereClause.between(
                indexName: r'externalId_platform',
                lower: [externalId],
                upper: [externalId, platform],
                includeUpper: false,
              ),
            )
            .addWhereClause(
              IndexWhereClause.between(
                indexName: r'externalId_platform',
                lower: [externalId, platform],
                includeLower: false,
                upper: [externalId],
              ),
            );
      } else {
        return query
            .addWhereClause(
              IndexWhereClause.between(
                indexName: r'externalId_platform',
                lower: [externalId, platform],
                includeLower: false,
                upper: [externalId],
              ),
            )
            .addWhereClause(
              IndexWhereClause.between(
                indexName: r'externalId_platform',
                lower: [externalId],
                upper: [externalId, platform],
                includeUpper: false,
              ),
            );
      }
    });
  }
}

extension AccountQueryFilter
    on QueryBuilder<Account, Account, QFilterCondition> {
  QueryBuilder<Account, Account, QAfterFilterCondition> accessTokenIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        const FilterCondition.isNull(property: r'accessToken'),
      );
    });
  }

  QueryBuilder<Account, Account, QAfterFilterCondition> accessTokenIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        const FilterCondition.isNotNull(property: r'accessToken'),
      );
    });
  }

  QueryBuilder<Account, Account, QAfterFilterCondition> accessTokenEqualTo(
    String? value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(
          property: r'accessToken',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<Account, Account, QAfterFilterCondition> accessTokenGreaterThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(
          include: include,
          property: r'accessToken',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<Account, Account, QAfterFilterCondition> accessTokenLessThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.lessThan(
          include: include,
          property: r'accessToken',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<Account, Account, QAfterFilterCondition> accessTokenBetween(
    String? lower,
    String? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.between(
          property: r'accessToken',
          lower: lower,
          includeLower: includeLower,
          upper: upper,
          includeUpper: includeUpper,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<Account, Account, QAfterFilterCondition> accessTokenStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.startsWith(
          property: r'accessToken',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<Account, Account, QAfterFilterCondition> accessTokenEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.endsWith(
          property: r'accessToken',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<Account, Account, QAfterFilterCondition> accessTokenContains(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.contains(
          property: r'accessToken',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<Account, Account, QAfterFilterCondition> accessTokenMatches(
    String pattern, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.matches(
          property: r'accessToken',
          wildcard: pattern,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<Account, Account, QAfterFilterCondition> accessTokenIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(property: r'accessToken', value: ''),
      );
    });
  }

  QueryBuilder<Account, Account, QAfterFilterCondition>
  accessTokenIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(property: r'accessToken', value: ''),
      );
    });
  }

  QueryBuilder<Account, Account, QAfterFilterCondition> additionalDataIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        const FilterCondition.isNull(property: r'additionalData'),
      );
    });
  }

  QueryBuilder<Account, Account, QAfterFilterCondition>
  additionalDataIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        const FilterCondition.isNotNull(property: r'additionalData'),
      );
    });
  }

  QueryBuilder<Account, Account, QAfterFilterCondition> additionalDataEqualTo(
    String? value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(
          property: r'additionalData',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<Account, Account, QAfterFilterCondition>
  additionalDataGreaterThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(
          include: include,
          property: r'additionalData',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<Account, Account, QAfterFilterCondition> additionalDataLessThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.lessThan(
          include: include,
          property: r'additionalData',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<Account, Account, QAfterFilterCondition> additionalDataBetween(
    String? lower,
    String? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.between(
          property: r'additionalData',
          lower: lower,
          includeLower: includeLower,
          upper: upper,
          includeUpper: includeUpper,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<Account, Account, QAfterFilterCondition>
  additionalDataStartsWith(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.startsWith(
          property: r'additionalData',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<Account, Account, QAfterFilterCondition> additionalDataEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.endsWith(
          property: r'additionalData',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<Account, Account, QAfterFilterCondition> additionalDataContains(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.contains(
          property: r'additionalData',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<Account, Account, QAfterFilterCondition> additionalDataMatches(
    String pattern, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.matches(
          property: r'additionalData',
          wildcard: pattern,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<Account, Account, QAfterFilterCondition>
  additionalDataIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(property: r'additionalData', value: ''),
      );
    });
  }

  QueryBuilder<Account, Account, QAfterFilterCondition>
  additionalDataIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(property: r'additionalData', value: ''),
      );
    });
  }

  QueryBuilder<Account, Account, QAfterFilterCondition> apiKeyIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        const FilterCondition.isNull(property: r'apiKey'),
      );
    });
  }

  QueryBuilder<Account, Account, QAfterFilterCondition> apiKeyIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        const FilterCondition.isNotNull(property: r'apiKey'),
      );
    });
  }

  QueryBuilder<Account, Account, QAfterFilterCondition> apiKeyEqualTo(
    String? value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(
          property: r'apiKey',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<Account, Account, QAfterFilterCondition> apiKeyGreaterThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(
          include: include,
          property: r'apiKey',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<Account, Account, QAfterFilterCondition> apiKeyLessThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.lessThan(
          include: include,
          property: r'apiKey',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<Account, Account, QAfterFilterCondition> apiKeyBetween(
    String? lower,
    String? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.between(
          property: r'apiKey',
          lower: lower,
          includeLower: includeLower,
          upper: upper,
          includeUpper: includeUpper,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<Account, Account, QAfterFilterCondition> apiKeyStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.startsWith(
          property: r'apiKey',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<Account, Account, QAfterFilterCondition> apiKeyEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.endsWith(
          property: r'apiKey',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<Account, Account, QAfterFilterCondition> apiKeyContains(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.contains(
          property: r'apiKey',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<Account, Account, QAfterFilterCondition> apiKeyMatches(
    String pattern, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.matches(
          property: r'apiKey',
          wildcard: pattern,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<Account, Account, QAfterFilterCondition> apiKeyIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(property: r'apiKey', value: ''),
      );
    });
  }

  QueryBuilder<Account, Account, QAfterFilterCondition> apiKeyIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(property: r'apiKey', value: ''),
      );
    });
  }

  QueryBuilder<Account, Account, QAfterFilterCondition> avatarUrlIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        const FilterCondition.isNull(property: r'avatarUrl'),
      );
    });
  }

  QueryBuilder<Account, Account, QAfterFilterCondition> avatarUrlIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        const FilterCondition.isNotNull(property: r'avatarUrl'),
      );
    });
  }

  QueryBuilder<Account, Account, QAfterFilterCondition> avatarUrlEqualTo(
    String? value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(
          property: r'avatarUrl',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<Account, Account, QAfterFilterCondition> avatarUrlGreaterThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(
          include: include,
          property: r'avatarUrl',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<Account, Account, QAfterFilterCondition> avatarUrlLessThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.lessThan(
          include: include,
          property: r'avatarUrl',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<Account, Account, QAfterFilterCondition> avatarUrlBetween(
    String? lower,
    String? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.between(
          property: r'avatarUrl',
          lower: lower,
          includeLower: includeLower,
          upper: upper,
          includeUpper: includeUpper,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<Account, Account, QAfterFilterCondition> avatarUrlStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.startsWith(
          property: r'avatarUrl',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<Account, Account, QAfterFilterCondition> avatarUrlEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.endsWith(
          property: r'avatarUrl',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<Account, Account, QAfterFilterCondition> avatarUrlContains(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.contains(
          property: r'avatarUrl',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<Account, Account, QAfterFilterCondition> avatarUrlMatches(
    String pattern, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.matches(
          property: r'avatarUrl',
          wildcard: pattern,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<Account, Account, QAfterFilterCondition> avatarUrlIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(property: r'avatarUrl', value: ''),
      );
    });
  }

  QueryBuilder<Account, Account, QAfterFilterCondition> avatarUrlIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(property: r'avatarUrl', value: ''),
      );
    });
  }

  QueryBuilder<Account, Account, QAfterFilterCondition> bindTimeIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        const FilterCondition.isNull(property: r'bindTime'),
      );
    });
  }

  QueryBuilder<Account, Account, QAfterFilterCondition> bindTimeIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        const FilterCondition.isNotNull(property: r'bindTime'),
      );
    });
  }

  QueryBuilder<Account, Account, QAfterFilterCondition> bindTimeEqualTo(
    DateTime? value,
  ) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(property: r'bindTime', value: value),
      );
    });
  }

  QueryBuilder<Account, Account, QAfterFilterCondition> bindTimeGreaterThan(
    DateTime? value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(
          include: include,
          property: r'bindTime',
          value: value,
        ),
      );
    });
  }

  QueryBuilder<Account, Account, QAfterFilterCondition> bindTimeLessThan(
    DateTime? value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.lessThan(
          include: include,
          property: r'bindTime',
          value: value,
        ),
      );
    });
  }

  QueryBuilder<Account, Account, QAfterFilterCondition> bindTimeBetween(
    DateTime? lower,
    DateTime? upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.between(
          property: r'bindTime',
          lower: lower,
          includeLower: includeLower,
          upper: upper,
          includeUpper: includeUpper,
        ),
      );
    });
  }

  QueryBuilder<Account, Account, QAfterFilterCondition>
  credentialCreatedAtIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        const FilterCondition.isNull(property: r'credentialCreatedAt'),
      );
    });
  }

  QueryBuilder<Account, Account, QAfterFilterCondition>
  credentialCreatedAtIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        const FilterCondition.isNotNull(property: r'credentialCreatedAt'),
      );
    });
  }

  QueryBuilder<Account, Account, QAfterFilterCondition>
  credentialCreatedAtEqualTo(DateTime? value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(property: r'credentialCreatedAt', value: value),
      );
    });
  }

  QueryBuilder<Account, Account, QAfterFilterCondition>
  credentialCreatedAtGreaterThan(DateTime? value, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(
          include: include,
          property: r'credentialCreatedAt',
          value: value,
        ),
      );
    });
  }

  QueryBuilder<Account, Account, QAfterFilterCondition>
  credentialCreatedAtLessThan(DateTime? value, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.lessThan(
          include: include,
          property: r'credentialCreatedAt',
          value: value,
        ),
      );
    });
  }

  QueryBuilder<Account, Account, QAfterFilterCondition>
  credentialCreatedAtBetween(
    DateTime? lower,
    DateTime? upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.between(
          property: r'credentialCreatedAt',
          lower: lower,
          includeLower: includeLower,
          upper: upper,
          includeUpper: includeUpper,
        ),
      );
    });
  }

  QueryBuilder<Account, Account, QAfterFilterCondition> credentialTypeEqualTo(
    CredentialType value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(
          property: r'credentialType',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<Account, Account, QAfterFilterCondition>
  credentialTypeGreaterThan(
    CredentialType value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(
          include: include,
          property: r'credentialType',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<Account, Account, QAfterFilterCondition> credentialTypeLessThan(
    CredentialType value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.lessThan(
          include: include,
          property: r'credentialType',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<Account, Account, QAfterFilterCondition> credentialTypeBetween(
    CredentialType lower,
    CredentialType upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.between(
          property: r'credentialType',
          lower: lower,
          includeLower: includeLower,
          upper: upper,
          includeUpper: includeUpper,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<Account, Account, QAfterFilterCondition>
  credentialTypeStartsWith(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.startsWith(
          property: r'credentialType',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<Account, Account, QAfterFilterCondition> credentialTypeEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.endsWith(
          property: r'credentialType',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<Account, Account, QAfterFilterCondition> credentialTypeContains(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.contains(
          property: r'credentialType',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<Account, Account, QAfterFilterCondition> credentialTypeMatches(
    String pattern, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.matches(
          property: r'credentialType',
          wildcard: pattern,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<Account, Account, QAfterFilterCondition>
  credentialTypeIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(property: r'credentialType', value: ''),
      );
    });
  }

  QueryBuilder<Account, Account, QAfterFilterCondition>
  credentialTypeIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(property: r'credentialType', value: ''),
      );
    });
  }

  QueryBuilder<Account, Account, QAfterFilterCondition>
  credentialUpdatedAtIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        const FilterCondition.isNull(property: r'credentialUpdatedAt'),
      );
    });
  }

  QueryBuilder<Account, Account, QAfterFilterCondition>
  credentialUpdatedAtIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        const FilterCondition.isNotNull(property: r'credentialUpdatedAt'),
      );
    });
  }

  QueryBuilder<Account, Account, QAfterFilterCondition>
  credentialUpdatedAtEqualTo(DateTime? value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(property: r'credentialUpdatedAt', value: value),
      );
    });
  }

  QueryBuilder<Account, Account, QAfterFilterCondition>
  credentialUpdatedAtGreaterThan(DateTime? value, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(
          include: include,
          property: r'credentialUpdatedAt',
          value: value,
        ),
      );
    });
  }

  QueryBuilder<Account, Account, QAfterFilterCondition>
  credentialUpdatedAtLessThan(DateTime? value, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.lessThan(
          include: include,
          property: r'credentialUpdatedAt',
          value: value,
        ),
      );
    });
  }

  QueryBuilder<Account, Account, QAfterFilterCondition>
  credentialUpdatedAtBetween(
    DateTime? lower,
    DateTime? upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.between(
          property: r'credentialUpdatedAt',
          lower: lower,
          includeLower: includeLower,
          upper: upper,
          includeUpper: includeUpper,
        ),
      );
    });
  }

  QueryBuilder<Account, Account, QAfterFilterCondition> displayNameIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        const FilterCondition.isNull(property: r'displayName'),
      );
    });
  }

  QueryBuilder<Account, Account, QAfterFilterCondition> displayNameIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        const FilterCondition.isNotNull(property: r'displayName'),
      );
    });
  }

  QueryBuilder<Account, Account, QAfterFilterCondition> displayNameEqualTo(
    String? value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(
          property: r'displayName',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<Account, Account, QAfterFilterCondition> displayNameGreaterThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(
          include: include,
          property: r'displayName',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<Account, Account, QAfterFilterCondition> displayNameLessThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.lessThan(
          include: include,
          property: r'displayName',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<Account, Account, QAfterFilterCondition> displayNameBetween(
    String? lower,
    String? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.between(
          property: r'displayName',
          lower: lower,
          includeLower: includeLower,
          upper: upper,
          includeUpper: includeUpper,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<Account, Account, QAfterFilterCondition> displayNameStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.startsWith(
          property: r'displayName',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<Account, Account, QAfterFilterCondition> displayNameEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.endsWith(
          property: r'displayName',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<Account, Account, QAfterFilterCondition> displayNameContains(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.contains(
          property: r'displayName',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<Account, Account, QAfterFilterCondition> displayNameMatches(
    String pattern, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.matches(
          property: r'displayName',
          wildcard: pattern,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<Account, Account, QAfterFilterCondition> displayNameIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(property: r'displayName', value: ''),
      );
    });
  }

  QueryBuilder<Account, Account, QAfterFilterCondition>
  displayNameIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(property: r'displayName', value: ''),
      );
    });
  }

  QueryBuilder<Account, Account, QAfterFilterCondition> externalIdEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(
          property: r'externalId',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<Account, Account, QAfterFilterCondition> externalIdGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(
          include: include,
          property: r'externalId',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<Account, Account, QAfterFilterCondition> externalIdLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.lessThan(
          include: include,
          property: r'externalId',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<Account, Account, QAfterFilterCondition> externalIdBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.between(
          property: r'externalId',
          lower: lower,
          includeLower: includeLower,
          upper: upper,
          includeUpper: includeUpper,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<Account, Account, QAfterFilterCondition> externalIdStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.startsWith(
          property: r'externalId',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<Account, Account, QAfterFilterCondition> externalIdEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.endsWith(
          property: r'externalId',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<Account, Account, QAfterFilterCondition> externalIdContains(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.contains(
          property: r'externalId',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<Account, Account, QAfterFilterCondition> externalIdMatches(
    String pattern, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.matches(
          property: r'externalId',
          wildcard: pattern,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<Account, Account, QAfterFilterCondition> externalIdIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(property: r'externalId', value: ''),
      );
    });
  }

  QueryBuilder<Account, Account, QAfterFilterCondition> externalIdIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(property: r'externalId', value: ''),
      );
    });
  }

  QueryBuilder<Account, Account, QAfterFilterCondition> idEqualTo(Id value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(property: r'id', value: value),
      );
    });
  }

  QueryBuilder<Account, Account, QAfterFilterCondition> idGreaterThan(
    Id value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(
          include: include,
          property: r'id',
          value: value,
        ),
      );
    });
  }

  QueryBuilder<Account, Account, QAfterFilterCondition> idLessThan(
    Id value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.lessThan(
          include: include,
          property: r'id',
          value: value,
        ),
      );
    });
  }

  QueryBuilder<Account, Account, QAfterFilterCondition> idBetween(
    Id lower,
    Id upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.between(
          property: r'id',
          lower: lower,
          includeLower: includeLower,
          upper: upper,
          includeUpper: includeUpper,
        ),
      );
    });
  }

  QueryBuilder<Account, Account, QAfterFilterCondition> isActiveEqualTo(
    bool value,
  ) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(property: r'isActive', value: value),
      );
    });
  }

  QueryBuilder<Account, Account, QAfterFilterCondition> isTokenExpiredEqualTo(
    bool value,
  ) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(property: r'isTokenExpired', value: value),
      );
    });
  }

  QueryBuilder<Account, Account, QAfterFilterCondition>
  isTokenExpiringSoonEqualTo(bool value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(property: r'isTokenExpiringSoon', value: value),
      );
    });
  }

  QueryBuilder<Account, Account, QAfterFilterCondition> lastSyncTimeIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        const FilterCondition.isNull(property: r'lastSyncTime'),
      );
    });
  }

  QueryBuilder<Account, Account, QAfterFilterCondition>
  lastSyncTimeIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        const FilterCondition.isNotNull(property: r'lastSyncTime'),
      );
    });
  }

  QueryBuilder<Account, Account, QAfterFilterCondition> lastSyncTimeEqualTo(
    DateTime? value,
  ) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(property: r'lastSyncTime', value: value),
      );
    });
  }

  QueryBuilder<Account, Account, QAfterFilterCondition> lastSyncTimeGreaterThan(
    DateTime? value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(
          include: include,
          property: r'lastSyncTime',
          value: value,
        ),
      );
    });
  }

  QueryBuilder<Account, Account, QAfterFilterCondition> lastSyncTimeLessThan(
    DateTime? value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.lessThan(
          include: include,
          property: r'lastSyncTime',
          value: value,
        ),
      );
    });
  }

  QueryBuilder<Account, Account, QAfterFilterCondition> lastSyncTimeBetween(
    DateTime? lower,
    DateTime? upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.between(
          property: r'lastSyncTime',
          lower: lower,
          includeLower: includeLower,
          upper: upper,
          includeUpper: includeUpper,
        ),
      );
    });
  }

  QueryBuilder<Account, Account, QAfterFilterCondition> metadataIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        const FilterCondition.isNull(property: r'metadata'),
      );
    });
  }

  QueryBuilder<Account, Account, QAfterFilterCondition> metadataIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        const FilterCondition.isNotNull(property: r'metadata'),
      );
    });
  }

  QueryBuilder<Account, Account, QAfterFilterCondition> metadataEqualTo(
    String? value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(
          property: r'metadata',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<Account, Account, QAfterFilterCondition> metadataGreaterThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(
          include: include,
          property: r'metadata',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<Account, Account, QAfterFilterCondition> metadataLessThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.lessThan(
          include: include,
          property: r'metadata',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<Account, Account, QAfterFilterCondition> metadataBetween(
    String? lower,
    String? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.between(
          property: r'metadata',
          lower: lower,
          includeLower: includeLower,
          upper: upper,
          includeUpper: includeUpper,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<Account, Account, QAfterFilterCondition> metadataStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.startsWith(
          property: r'metadata',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<Account, Account, QAfterFilterCondition> metadataEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.endsWith(
          property: r'metadata',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<Account, Account, QAfterFilterCondition> metadataContains(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.contains(
          property: r'metadata',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<Account, Account, QAfterFilterCondition> metadataMatches(
    String pattern, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.matches(
          property: r'metadata',
          wildcard: pattern,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<Account, Account, QAfterFilterCondition> metadataIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(property: r'metadata', value: ''),
      );
    });
  }

  QueryBuilder<Account, Account, QAfterFilterCondition> metadataIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(property: r'metadata', value: ''),
      );
    });
  }

  QueryBuilder<Account, Account, QAfterFilterCondition> passwordIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        const FilterCondition.isNull(property: r'password'),
      );
    });
  }

  QueryBuilder<Account, Account, QAfterFilterCondition> passwordIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        const FilterCondition.isNotNull(property: r'password'),
      );
    });
  }

  QueryBuilder<Account, Account, QAfterFilterCondition> passwordEqualTo(
    String? value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(
          property: r'password',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<Account, Account, QAfterFilterCondition> passwordGreaterThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(
          include: include,
          property: r'password',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<Account, Account, QAfterFilterCondition> passwordLessThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.lessThan(
          include: include,
          property: r'password',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<Account, Account, QAfterFilterCondition> passwordBetween(
    String? lower,
    String? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.between(
          property: r'password',
          lower: lower,
          includeLower: includeLower,
          upper: upper,
          includeUpper: includeUpper,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<Account, Account, QAfterFilterCondition> passwordStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.startsWith(
          property: r'password',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<Account, Account, QAfterFilterCondition> passwordEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.endsWith(
          property: r'password',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<Account, Account, QAfterFilterCondition> passwordContains(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.contains(
          property: r'password',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<Account, Account, QAfterFilterCondition> passwordMatches(
    String pattern, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.matches(
          property: r'password',
          wildcard: pattern,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<Account, Account, QAfterFilterCondition> passwordIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(property: r'password', value: ''),
      );
    });
  }

  QueryBuilder<Account, Account, QAfterFilterCondition> passwordIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(property: r'password', value: ''),
      );
    });
  }

  QueryBuilder<Account, Account, QAfterFilterCondition> platformEqualTo(
    Platform value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(
          property: r'platform',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<Account, Account, QAfterFilterCondition> platformGreaterThan(
    Platform value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(
          include: include,
          property: r'platform',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<Account, Account, QAfterFilterCondition> platformLessThan(
    Platform value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.lessThan(
          include: include,
          property: r'platform',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<Account, Account, QAfterFilterCondition> platformBetween(
    Platform lower,
    Platform upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.between(
          property: r'platform',
          lower: lower,
          includeLower: includeLower,
          upper: upper,
          includeUpper: includeUpper,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<Account, Account, QAfterFilterCondition> platformStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.startsWith(
          property: r'platform',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<Account, Account, QAfterFilterCondition> platformEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.endsWith(
          property: r'platform',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<Account, Account, QAfterFilterCondition> platformContains(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.contains(
          property: r'platform',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<Account, Account, QAfterFilterCondition> platformMatches(
    String pattern, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.matches(
          property: r'platform',
          wildcard: pattern,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<Account, Account, QAfterFilterCondition> platformIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(property: r'platform', value: ''),
      );
    });
  }

  QueryBuilder<Account, Account, QAfterFilterCondition> platformIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(property: r'platform', value: ''),
      );
    });
  }

  QueryBuilder<Account, Account, QAfterFilterCondition> refreshTokenIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        const FilterCondition.isNull(property: r'refreshToken'),
      );
    });
  }

  QueryBuilder<Account, Account, QAfterFilterCondition>
  refreshTokenIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        const FilterCondition.isNotNull(property: r'refreshToken'),
      );
    });
  }

  QueryBuilder<Account, Account, QAfterFilterCondition> refreshTokenEqualTo(
    String? value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(
          property: r'refreshToken',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<Account, Account, QAfterFilterCondition> refreshTokenGreaterThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(
          include: include,
          property: r'refreshToken',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<Account, Account, QAfterFilterCondition> refreshTokenLessThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.lessThan(
          include: include,
          property: r'refreshToken',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<Account, Account, QAfterFilterCondition> refreshTokenBetween(
    String? lower,
    String? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.between(
          property: r'refreshToken',
          lower: lower,
          includeLower: includeLower,
          upper: upper,
          includeUpper: includeUpper,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<Account, Account, QAfterFilterCondition> refreshTokenStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.startsWith(
          property: r'refreshToken',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<Account, Account, QAfterFilterCondition> refreshTokenEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.endsWith(
          property: r'refreshToken',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<Account, Account, QAfterFilterCondition> refreshTokenContains(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.contains(
          property: r'refreshToken',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<Account, Account, QAfterFilterCondition> refreshTokenMatches(
    String pattern, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.matches(
          property: r'refreshToken',
          wildcard: pattern,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<Account, Account, QAfterFilterCondition> refreshTokenIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(property: r'refreshToken', value: ''),
      );
    });
  }

  QueryBuilder<Account, Account, QAfterFilterCondition>
  refreshTokenIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(property: r'refreshToken', value: ''),
      );
    });
  }

  QueryBuilder<Account, Account, QAfterFilterCondition> tokenExpiryIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        const FilterCondition.isNull(property: r'tokenExpiry'),
      );
    });
  }

  QueryBuilder<Account, Account, QAfterFilterCondition> tokenExpiryIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        const FilterCondition.isNotNull(property: r'tokenExpiry'),
      );
    });
  }

  QueryBuilder<Account, Account, QAfterFilterCondition> tokenExpiryEqualTo(
    DateTime? value,
  ) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(property: r'tokenExpiry', value: value),
      );
    });
  }

  QueryBuilder<Account, Account, QAfterFilterCondition> tokenExpiryGreaterThan(
    DateTime? value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(
          include: include,
          property: r'tokenExpiry',
          value: value,
        ),
      );
    });
  }

  QueryBuilder<Account, Account, QAfterFilterCondition> tokenExpiryLessThan(
    DateTime? value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.lessThan(
          include: include,
          property: r'tokenExpiry',
          value: value,
        ),
      );
    });
  }

  QueryBuilder<Account, Account, QAfterFilterCondition> tokenExpiryBetween(
    DateTime? lower,
    DateTime? upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.between(
          property: r'tokenExpiry',
          lower: lower,
          includeLower: includeLower,
          upper: upper,
          includeUpper: includeUpper,
        ),
      );
    });
  }

  QueryBuilder<Account, Account, QAfterFilterCondition> usernameIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        const FilterCondition.isNull(property: r'username'),
      );
    });
  }

  QueryBuilder<Account, Account, QAfterFilterCondition> usernameIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        const FilterCondition.isNotNull(property: r'username'),
      );
    });
  }

  QueryBuilder<Account, Account, QAfterFilterCondition> usernameEqualTo(
    String? value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(
          property: r'username',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<Account, Account, QAfterFilterCondition> usernameGreaterThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(
          include: include,
          property: r'username',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<Account, Account, QAfterFilterCondition> usernameLessThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.lessThan(
          include: include,
          property: r'username',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<Account, Account, QAfterFilterCondition> usernameBetween(
    String? lower,
    String? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.between(
          property: r'username',
          lower: lower,
          includeLower: includeLower,
          upper: upper,
          includeUpper: includeUpper,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<Account, Account, QAfterFilterCondition> usernameStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.startsWith(
          property: r'username',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<Account, Account, QAfterFilterCondition> usernameEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.endsWith(
          property: r'username',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<Account, Account, QAfterFilterCondition> usernameContains(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.contains(
          property: r'username',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<Account, Account, QAfterFilterCondition> usernameMatches(
    String pattern, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.matches(
          property: r'username',
          wildcard: pattern,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<Account, Account, QAfterFilterCondition> usernameIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(property: r'username', value: ''),
      );
    });
  }

  QueryBuilder<Account, Account, QAfterFilterCondition> usernameIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(property: r'username', value: ''),
      );
    });
  }
}

extension AccountQueryObject
    on QueryBuilder<Account, Account, QFilterCondition> {}

extension AccountQueryLinks
    on QueryBuilder<Account, Account, QFilterCondition> {}

extension AccountQuerySortBy on QueryBuilder<Account, Account, QSortBy> {
  QueryBuilder<Account, Account, QAfterSortBy> sortByAccessToken() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'accessToken', Sort.asc);
    });
  }

  QueryBuilder<Account, Account, QAfterSortBy> sortByAccessTokenDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'accessToken', Sort.desc);
    });
  }

  QueryBuilder<Account, Account, QAfterSortBy> sortByAdditionalData() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'additionalData', Sort.asc);
    });
  }

  QueryBuilder<Account, Account, QAfterSortBy> sortByAdditionalDataDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'additionalData', Sort.desc);
    });
  }

  QueryBuilder<Account, Account, QAfterSortBy> sortByApiKey() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'apiKey', Sort.asc);
    });
  }

  QueryBuilder<Account, Account, QAfterSortBy> sortByApiKeyDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'apiKey', Sort.desc);
    });
  }

  QueryBuilder<Account, Account, QAfterSortBy> sortByAvatarUrl() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'avatarUrl', Sort.asc);
    });
  }

  QueryBuilder<Account, Account, QAfterSortBy> sortByAvatarUrlDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'avatarUrl', Sort.desc);
    });
  }

  QueryBuilder<Account, Account, QAfterSortBy> sortByBindTime() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'bindTime', Sort.asc);
    });
  }

  QueryBuilder<Account, Account, QAfterSortBy> sortByBindTimeDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'bindTime', Sort.desc);
    });
  }

  QueryBuilder<Account, Account, QAfterSortBy> sortByCredentialCreatedAt() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'credentialCreatedAt', Sort.asc);
    });
  }

  QueryBuilder<Account, Account, QAfterSortBy> sortByCredentialCreatedAtDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'credentialCreatedAt', Sort.desc);
    });
  }

  QueryBuilder<Account, Account, QAfterSortBy> sortByCredentialType() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'credentialType', Sort.asc);
    });
  }

  QueryBuilder<Account, Account, QAfterSortBy> sortByCredentialTypeDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'credentialType', Sort.desc);
    });
  }

  QueryBuilder<Account, Account, QAfterSortBy> sortByCredentialUpdatedAt() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'credentialUpdatedAt', Sort.asc);
    });
  }

  QueryBuilder<Account, Account, QAfterSortBy> sortByCredentialUpdatedAtDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'credentialUpdatedAt', Sort.desc);
    });
  }

  QueryBuilder<Account, Account, QAfterSortBy> sortByDisplayName() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'displayName', Sort.asc);
    });
  }

  QueryBuilder<Account, Account, QAfterSortBy> sortByDisplayNameDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'displayName', Sort.desc);
    });
  }

  QueryBuilder<Account, Account, QAfterSortBy> sortByExternalId() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'externalId', Sort.asc);
    });
  }

  QueryBuilder<Account, Account, QAfterSortBy> sortByExternalIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'externalId', Sort.desc);
    });
  }

  QueryBuilder<Account, Account, QAfterSortBy> sortByIsActive() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isActive', Sort.asc);
    });
  }

  QueryBuilder<Account, Account, QAfterSortBy> sortByIsActiveDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isActive', Sort.desc);
    });
  }

  QueryBuilder<Account, Account, QAfterSortBy> sortByIsTokenExpired() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isTokenExpired', Sort.asc);
    });
  }

  QueryBuilder<Account, Account, QAfterSortBy> sortByIsTokenExpiredDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isTokenExpired', Sort.desc);
    });
  }

  QueryBuilder<Account, Account, QAfterSortBy> sortByIsTokenExpiringSoon() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isTokenExpiringSoon', Sort.asc);
    });
  }

  QueryBuilder<Account, Account, QAfterSortBy> sortByIsTokenExpiringSoonDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isTokenExpiringSoon', Sort.desc);
    });
  }

  QueryBuilder<Account, Account, QAfterSortBy> sortByLastSyncTime() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'lastSyncTime', Sort.asc);
    });
  }

  QueryBuilder<Account, Account, QAfterSortBy> sortByLastSyncTimeDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'lastSyncTime', Sort.desc);
    });
  }

  QueryBuilder<Account, Account, QAfterSortBy> sortByMetadata() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'metadata', Sort.asc);
    });
  }

  QueryBuilder<Account, Account, QAfterSortBy> sortByMetadataDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'metadata', Sort.desc);
    });
  }

  QueryBuilder<Account, Account, QAfterSortBy> sortByPassword() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'password', Sort.asc);
    });
  }

  QueryBuilder<Account, Account, QAfterSortBy> sortByPasswordDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'password', Sort.desc);
    });
  }

  QueryBuilder<Account, Account, QAfterSortBy> sortByPlatform() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'platform', Sort.asc);
    });
  }

  QueryBuilder<Account, Account, QAfterSortBy> sortByPlatformDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'platform', Sort.desc);
    });
  }

  QueryBuilder<Account, Account, QAfterSortBy> sortByRefreshToken() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'refreshToken', Sort.asc);
    });
  }

  QueryBuilder<Account, Account, QAfterSortBy> sortByRefreshTokenDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'refreshToken', Sort.desc);
    });
  }

  QueryBuilder<Account, Account, QAfterSortBy> sortByTokenExpiry() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'tokenExpiry', Sort.asc);
    });
  }

  QueryBuilder<Account, Account, QAfterSortBy> sortByTokenExpiryDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'tokenExpiry', Sort.desc);
    });
  }

  QueryBuilder<Account, Account, QAfterSortBy> sortByUsername() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'username', Sort.asc);
    });
  }

  QueryBuilder<Account, Account, QAfterSortBy> sortByUsernameDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'username', Sort.desc);
    });
  }
}

extension AccountQuerySortThenBy
    on QueryBuilder<Account, Account, QSortThenBy> {
  QueryBuilder<Account, Account, QAfterSortBy> thenByAccessToken() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'accessToken', Sort.asc);
    });
  }

  QueryBuilder<Account, Account, QAfterSortBy> thenByAccessTokenDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'accessToken', Sort.desc);
    });
  }

  QueryBuilder<Account, Account, QAfterSortBy> thenByAdditionalData() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'additionalData', Sort.asc);
    });
  }

  QueryBuilder<Account, Account, QAfterSortBy> thenByAdditionalDataDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'additionalData', Sort.desc);
    });
  }

  QueryBuilder<Account, Account, QAfterSortBy> thenByApiKey() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'apiKey', Sort.asc);
    });
  }

  QueryBuilder<Account, Account, QAfterSortBy> thenByApiKeyDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'apiKey', Sort.desc);
    });
  }

  QueryBuilder<Account, Account, QAfterSortBy> thenByAvatarUrl() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'avatarUrl', Sort.asc);
    });
  }

  QueryBuilder<Account, Account, QAfterSortBy> thenByAvatarUrlDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'avatarUrl', Sort.desc);
    });
  }

  QueryBuilder<Account, Account, QAfterSortBy> thenByBindTime() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'bindTime', Sort.asc);
    });
  }

  QueryBuilder<Account, Account, QAfterSortBy> thenByBindTimeDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'bindTime', Sort.desc);
    });
  }

  QueryBuilder<Account, Account, QAfterSortBy> thenByCredentialCreatedAt() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'credentialCreatedAt', Sort.asc);
    });
  }

  QueryBuilder<Account, Account, QAfterSortBy> thenByCredentialCreatedAtDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'credentialCreatedAt', Sort.desc);
    });
  }

  QueryBuilder<Account, Account, QAfterSortBy> thenByCredentialType() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'credentialType', Sort.asc);
    });
  }

  QueryBuilder<Account, Account, QAfterSortBy> thenByCredentialTypeDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'credentialType', Sort.desc);
    });
  }

  QueryBuilder<Account, Account, QAfterSortBy> thenByCredentialUpdatedAt() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'credentialUpdatedAt', Sort.asc);
    });
  }

  QueryBuilder<Account, Account, QAfterSortBy> thenByCredentialUpdatedAtDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'credentialUpdatedAt', Sort.desc);
    });
  }

  QueryBuilder<Account, Account, QAfterSortBy> thenByDisplayName() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'displayName', Sort.asc);
    });
  }

  QueryBuilder<Account, Account, QAfterSortBy> thenByDisplayNameDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'displayName', Sort.desc);
    });
  }

  QueryBuilder<Account, Account, QAfterSortBy> thenByExternalId() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'externalId', Sort.asc);
    });
  }

  QueryBuilder<Account, Account, QAfterSortBy> thenByExternalIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'externalId', Sort.desc);
    });
  }

  QueryBuilder<Account, Account, QAfterSortBy> thenById() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.asc);
    });
  }

  QueryBuilder<Account, Account, QAfterSortBy> thenByIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.desc);
    });
  }

  QueryBuilder<Account, Account, QAfterSortBy> thenByIsActive() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isActive', Sort.asc);
    });
  }

  QueryBuilder<Account, Account, QAfterSortBy> thenByIsActiveDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isActive', Sort.desc);
    });
  }

  QueryBuilder<Account, Account, QAfterSortBy> thenByIsTokenExpired() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isTokenExpired', Sort.asc);
    });
  }

  QueryBuilder<Account, Account, QAfterSortBy> thenByIsTokenExpiredDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isTokenExpired', Sort.desc);
    });
  }

  QueryBuilder<Account, Account, QAfterSortBy> thenByIsTokenExpiringSoon() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isTokenExpiringSoon', Sort.asc);
    });
  }

  QueryBuilder<Account, Account, QAfterSortBy> thenByIsTokenExpiringSoonDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isTokenExpiringSoon', Sort.desc);
    });
  }

  QueryBuilder<Account, Account, QAfterSortBy> thenByLastSyncTime() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'lastSyncTime', Sort.asc);
    });
  }

  QueryBuilder<Account, Account, QAfterSortBy> thenByLastSyncTimeDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'lastSyncTime', Sort.desc);
    });
  }

  QueryBuilder<Account, Account, QAfterSortBy> thenByMetadata() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'metadata', Sort.asc);
    });
  }

  QueryBuilder<Account, Account, QAfterSortBy> thenByMetadataDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'metadata', Sort.desc);
    });
  }

  QueryBuilder<Account, Account, QAfterSortBy> thenByPassword() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'password', Sort.asc);
    });
  }

  QueryBuilder<Account, Account, QAfterSortBy> thenByPasswordDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'password', Sort.desc);
    });
  }

  QueryBuilder<Account, Account, QAfterSortBy> thenByPlatform() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'platform', Sort.asc);
    });
  }

  QueryBuilder<Account, Account, QAfterSortBy> thenByPlatformDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'platform', Sort.desc);
    });
  }

  QueryBuilder<Account, Account, QAfterSortBy> thenByRefreshToken() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'refreshToken', Sort.asc);
    });
  }

  QueryBuilder<Account, Account, QAfterSortBy> thenByRefreshTokenDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'refreshToken', Sort.desc);
    });
  }

  QueryBuilder<Account, Account, QAfterSortBy> thenByTokenExpiry() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'tokenExpiry', Sort.asc);
    });
  }

  QueryBuilder<Account, Account, QAfterSortBy> thenByTokenExpiryDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'tokenExpiry', Sort.desc);
    });
  }

  QueryBuilder<Account, Account, QAfterSortBy> thenByUsername() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'username', Sort.asc);
    });
  }

  QueryBuilder<Account, Account, QAfterSortBy> thenByUsernameDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'username', Sort.desc);
    });
  }
}

extension AccountQueryWhereDistinct
    on QueryBuilder<Account, Account, QDistinct> {
  QueryBuilder<Account, Account, QDistinct> distinctByAccessToken({
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'accessToken', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<Account, Account, QDistinct> distinctByAdditionalData({
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(
        r'additionalData',
        caseSensitive: caseSensitive,
      );
    });
  }

  QueryBuilder<Account, Account, QDistinct> distinctByApiKey({
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'apiKey', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<Account, Account, QDistinct> distinctByAvatarUrl({
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'avatarUrl', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<Account, Account, QDistinct> distinctByBindTime() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'bindTime');
    });
  }

  QueryBuilder<Account, Account, QDistinct> distinctByCredentialCreatedAt() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'credentialCreatedAt');
    });
  }

  QueryBuilder<Account, Account, QDistinct> distinctByCredentialType({
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(
        r'credentialType',
        caseSensitive: caseSensitive,
      );
    });
  }

  QueryBuilder<Account, Account, QDistinct> distinctByCredentialUpdatedAt() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'credentialUpdatedAt');
    });
  }

  QueryBuilder<Account, Account, QDistinct> distinctByDisplayName({
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'displayName', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<Account, Account, QDistinct> distinctByExternalId({
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'externalId', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<Account, Account, QDistinct> distinctByIsActive() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'isActive');
    });
  }

  QueryBuilder<Account, Account, QDistinct> distinctByIsTokenExpired() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'isTokenExpired');
    });
  }

  QueryBuilder<Account, Account, QDistinct> distinctByIsTokenExpiringSoon() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'isTokenExpiringSoon');
    });
  }

  QueryBuilder<Account, Account, QDistinct> distinctByLastSyncTime() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'lastSyncTime');
    });
  }

  QueryBuilder<Account, Account, QDistinct> distinctByMetadata({
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'metadata', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<Account, Account, QDistinct> distinctByPassword({
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'password', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<Account, Account, QDistinct> distinctByPlatform({
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'platform', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<Account, Account, QDistinct> distinctByRefreshToken({
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'refreshToken', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<Account, Account, QDistinct> distinctByTokenExpiry() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'tokenExpiry');
    });
  }

  QueryBuilder<Account, Account, QDistinct> distinctByUsername({
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'username', caseSensitive: caseSensitive);
    });
  }
}

extension AccountQueryProperty
    on QueryBuilder<Account, Account, QQueryProperty> {
  QueryBuilder<Account, int, QQueryOperations> idProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'id');
    });
  }

  QueryBuilder<Account, String?, QQueryOperations> accessTokenProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'accessToken');
    });
  }

  QueryBuilder<Account, String?, QQueryOperations> additionalDataProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'additionalData');
    });
  }

  QueryBuilder<Account, String?, QQueryOperations> apiKeyProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'apiKey');
    });
  }

  QueryBuilder<Account, String?, QQueryOperations> avatarUrlProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'avatarUrl');
    });
  }

  QueryBuilder<Account, DateTime?, QQueryOperations> bindTimeProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'bindTime');
    });
  }

  QueryBuilder<Account, DateTime?, QQueryOperations>
  credentialCreatedAtProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'credentialCreatedAt');
    });
  }

  QueryBuilder<Account, CredentialType, QQueryOperations>
  credentialTypeProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'credentialType');
    });
  }

  QueryBuilder<Account, DateTime?, QQueryOperations>
  credentialUpdatedAtProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'credentialUpdatedAt');
    });
  }

  QueryBuilder<Account, String?, QQueryOperations> displayNameProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'displayName');
    });
  }

  QueryBuilder<Account, String, QQueryOperations> externalIdProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'externalId');
    });
  }

  QueryBuilder<Account, bool, QQueryOperations> isActiveProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'isActive');
    });
  }

  QueryBuilder<Account, bool, QQueryOperations> isTokenExpiredProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'isTokenExpired');
    });
  }

  QueryBuilder<Account, bool, QQueryOperations> isTokenExpiringSoonProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'isTokenExpiringSoon');
    });
  }

  QueryBuilder<Account, DateTime?, QQueryOperations> lastSyncTimeProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'lastSyncTime');
    });
  }

  QueryBuilder<Account, String?, QQueryOperations> metadataProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'metadata');
    });
  }

  QueryBuilder<Account, String?, QQueryOperations> passwordProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'password');
    });
  }

  QueryBuilder<Account, Platform, QQueryOperations> platformProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'platform');
    });
  }

  QueryBuilder<Account, String?, QQueryOperations> refreshTokenProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'refreshToken');
    });
  }

  QueryBuilder<Account, DateTime?, QQueryOperations> tokenExpiryProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'tokenExpiry');
    });
  }

  QueryBuilder<Account, String?, QQueryOperations> usernameProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'username');
    });
  }
}
