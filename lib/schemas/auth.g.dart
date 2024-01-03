// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'auth.dart';

// **************************************************************************
// IsarCollectionGenerator
// **************************************************************************

// coverage:ignore-file
// ignore_for_file: duplicate_ignore, non_constant_identifier_names, constant_identifier_names, invalid_use_of_protected_member, unnecessary_cast, prefer_const_constructors, lines_longer_than_80_chars, require_trailing_commas, inference_failure_on_function_invocation, unnecessary_parenthesis, unnecessary_raw_strings, unnecessary_null_checks, join_return_with_assignment, prefer_final_locals, avoid_js_rounded_ints, avoid_positional_boolean_parameters, always_specify_types

extension GetAuthenticationCollection on Isar {
  IsarCollection<Authentication> get authentications => this.collection();
}

const AuthenticationSchema = CollectionSchema(
  name: r'Authentication',
  id: 6966287384112473639,
  properties: {
    r'mainAccessNumber': PropertySchema(
      id: 0,
      name: r'mainAccessNumber',
      type: IsarType.string,
    )
  },
  estimateSize: _authenticationEstimateSize,
  serialize: _authenticationSerialize,
  deserialize: _authenticationDeserialize,
  deserializeProp: _authenticationDeserializeProp,
  idName: r'userId',
  indexes: {},
  links: {},
  embeddedSchemas: {},
  getId: _authenticationGetId,
  getLinks: _authenticationGetLinks,
  attach: _authenticationAttach,
  version: '3.1.0+1',
);

int _authenticationEstimateSize(
  Authentication object,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  var bytesCount = offsets.last;
  {
    final value = object.mainAccessNumber;
    if (value != null) {
      bytesCount += 3 + value.length * 3;
    }
  }
  return bytesCount;
}

void _authenticationSerialize(
  Authentication object,
  IsarWriter writer,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  writer.writeString(offsets[0], object.mainAccessNumber);
}

Authentication _authenticationDeserialize(
  Id id,
  IsarReader reader,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  final object = Authentication();
  object.mainAccessNumber = reader.readStringOrNull(offsets[0]);
  object.userId = id;
  return object;
}

P _authenticationDeserializeProp<P>(
  IsarReader reader,
  int propertyId,
  int offset,
  Map<Type, List<int>> allOffsets,
) {
  switch (propertyId) {
    case 0:
      return (reader.readStringOrNull(offset)) as P;
    default:
      throw IsarError('Unknown property with id $propertyId');
  }
}

Id _authenticationGetId(Authentication object) {
  return object.userId;
}

List<IsarLinkBase<dynamic>> _authenticationGetLinks(Authentication object) {
  return [];
}

void _authenticationAttach(
    IsarCollection<dynamic> col, Id id, Authentication object) {
  object.userId = id;
}

extension AuthenticationQueryWhereSort
    on QueryBuilder<Authentication, Authentication, QWhere> {
  QueryBuilder<Authentication, Authentication, QAfterWhere> anyUserId() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(const IdWhereClause.any());
    });
  }
}

extension AuthenticationQueryWhere
    on QueryBuilder<Authentication, Authentication, QWhereClause> {
  QueryBuilder<Authentication, Authentication, QAfterWhereClause> userIdEqualTo(
      Id userId) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IdWhereClause.between(
        lower: userId,
        upper: userId,
      ));
    });
  }

  QueryBuilder<Authentication, Authentication, QAfterWhereClause>
      userIdNotEqualTo(Id userId) {
    return QueryBuilder.apply(this, (query) {
      if (query.whereSort == Sort.asc) {
        return query
            .addWhereClause(
              IdWhereClause.lessThan(upper: userId, includeUpper: false),
            )
            .addWhereClause(
              IdWhereClause.greaterThan(lower: userId, includeLower: false),
            );
      } else {
        return query
            .addWhereClause(
              IdWhereClause.greaterThan(lower: userId, includeLower: false),
            )
            .addWhereClause(
              IdWhereClause.lessThan(upper: userId, includeUpper: false),
            );
      }
    });
  }

  QueryBuilder<Authentication, Authentication, QAfterWhereClause>
      userIdGreaterThan(Id userId, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.greaterThan(lower: userId, includeLower: include),
      );
    });
  }

  QueryBuilder<Authentication, Authentication, QAfterWhereClause>
      userIdLessThan(Id userId, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.lessThan(upper: userId, includeUpper: include),
      );
    });
  }

  QueryBuilder<Authentication, Authentication, QAfterWhereClause> userIdBetween(
    Id lowerUserId,
    Id upperUserId, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IdWhereClause.between(
        lower: lowerUserId,
        includeLower: includeLower,
        upper: upperUserId,
        includeUpper: includeUpper,
      ));
    });
  }
}

extension AuthenticationQueryFilter
    on QueryBuilder<Authentication, Authentication, QFilterCondition> {
  QueryBuilder<Authentication, Authentication, QAfterFilterCondition>
      mainAccessNumberIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'mainAccessNumber',
      ));
    });
  }

  QueryBuilder<Authentication, Authentication, QAfterFilterCondition>
      mainAccessNumberIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'mainAccessNumber',
      ));
    });
  }

  QueryBuilder<Authentication, Authentication, QAfterFilterCondition>
      mainAccessNumberEqualTo(
    String? value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'mainAccessNumber',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Authentication, Authentication, QAfterFilterCondition>
      mainAccessNumberGreaterThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'mainAccessNumber',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Authentication, Authentication, QAfterFilterCondition>
      mainAccessNumberLessThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'mainAccessNumber',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Authentication, Authentication, QAfterFilterCondition>
      mainAccessNumberBetween(
    String? lower,
    String? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'mainAccessNumber',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Authentication, Authentication, QAfterFilterCondition>
      mainAccessNumberStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'mainAccessNumber',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Authentication, Authentication, QAfterFilterCondition>
      mainAccessNumberEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'mainAccessNumber',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Authentication, Authentication, QAfterFilterCondition>
      mainAccessNumberContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'mainAccessNumber',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Authentication, Authentication, QAfterFilterCondition>
      mainAccessNumberMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'mainAccessNumber',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Authentication, Authentication, QAfterFilterCondition>
      mainAccessNumberIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'mainAccessNumber',
        value: '',
      ));
    });
  }

  QueryBuilder<Authentication, Authentication, QAfterFilterCondition>
      mainAccessNumberIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'mainAccessNumber',
        value: '',
      ));
    });
  }

  QueryBuilder<Authentication, Authentication, QAfterFilterCondition>
      userIdEqualTo(Id value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'userId',
        value: value,
      ));
    });
  }

  QueryBuilder<Authentication, Authentication, QAfterFilterCondition>
      userIdGreaterThan(
    Id value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'userId',
        value: value,
      ));
    });
  }

  QueryBuilder<Authentication, Authentication, QAfterFilterCondition>
      userIdLessThan(
    Id value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'userId',
        value: value,
      ));
    });
  }

  QueryBuilder<Authentication, Authentication, QAfterFilterCondition>
      userIdBetween(
    Id lower,
    Id upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'userId',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }
}

extension AuthenticationQueryObject
    on QueryBuilder<Authentication, Authentication, QFilterCondition> {}

extension AuthenticationQueryLinks
    on QueryBuilder<Authentication, Authentication, QFilterCondition> {}

extension AuthenticationQuerySortBy
    on QueryBuilder<Authentication, Authentication, QSortBy> {
  QueryBuilder<Authentication, Authentication, QAfterSortBy>
      sortByMainAccessNumber() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'mainAccessNumber', Sort.asc);
    });
  }

  QueryBuilder<Authentication, Authentication, QAfterSortBy>
      sortByMainAccessNumberDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'mainAccessNumber', Sort.desc);
    });
  }
}

extension AuthenticationQuerySortThenBy
    on QueryBuilder<Authentication, Authentication, QSortThenBy> {
  QueryBuilder<Authentication, Authentication, QAfterSortBy>
      thenByMainAccessNumber() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'mainAccessNumber', Sort.asc);
    });
  }

  QueryBuilder<Authentication, Authentication, QAfterSortBy>
      thenByMainAccessNumberDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'mainAccessNumber', Sort.desc);
    });
  }

  QueryBuilder<Authentication, Authentication, QAfterSortBy> thenByUserId() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'userId', Sort.asc);
    });
  }

  QueryBuilder<Authentication, Authentication, QAfterSortBy>
      thenByUserIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'userId', Sort.desc);
    });
  }
}

extension AuthenticationQueryWhereDistinct
    on QueryBuilder<Authentication, Authentication, QDistinct> {
  QueryBuilder<Authentication, Authentication, QDistinct>
      distinctByMainAccessNumber({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'mainAccessNumber',
          caseSensitive: caseSensitive);
    });
  }
}

extension AuthenticationQueryProperty
    on QueryBuilder<Authentication, Authentication, QQueryProperty> {
  QueryBuilder<Authentication, int, QQueryOperations> userIdProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'userId');
    });
  }

  QueryBuilder<Authentication, String?, QQueryOperations>
      mainAccessNumberProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'mainAccessNumber');
    });
  }
}
