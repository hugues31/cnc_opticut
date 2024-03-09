// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'material_item.dart';

// **************************************************************************
// IsarCollectionGenerator
// **************************************************************************

// coverage:ignore-file
// ignore_for_file: duplicate_ignore, non_constant_identifier_names, constant_identifier_names, invalid_use_of_protected_member, unnecessary_cast, prefer_const_constructors, lines_longer_than_80_chars, require_trailing_commas, inference_failure_on_function_invocation, unnecessary_parenthesis, unnecessary_raw_strings, unnecessary_null_checks, join_return_with_assignment, prefer_final_locals, avoid_js_rounded_ints, avoid_positional_boolean_parameters, always_specify_types

extension GetMaterialItemCollection on Isar {
  IsarCollection<MaterialItem> get materialItems => this.collection();
}

const MaterialItemSchema = CollectionSchema(
  name: r'MaterialItem',
  id: 3678418569080105858,
  properties: {
    r'imagePath': PropertySchema(
      id: 0,
      name: r'imagePath',
      type: IsarType.string,
    ),
    r'isPreset': PropertySchema(
      id: 1,
      name: r'isPreset',
      type: IsarType.bool,
    ),
    r'materialSpecs': PropertySchema(
      id: 2,
      name: r'materialSpecs',
      type: IsarType.object,
      target: r'MaterialSpecs',
    ),
    r'nameKey': PropertySchema(
      id: 3,
      name: r'nameKey',
      type: IsarType.string,
    )
  },
  estimateSize: _materialItemEstimateSize,
  serialize: _materialItemSerialize,
  deserialize: _materialItemDeserialize,
  deserializeProp: _materialItemDeserializeProp,
  idName: r'id',
  indexes: {},
  links: {},
  embeddedSchemas: {r'MaterialSpecs': MaterialSpecsSchema},
  getId: _materialItemGetId,
  getLinks: _materialItemGetLinks,
  attach: _materialItemAttach,
  version: '3.1.3',
);

int _materialItemEstimateSize(
  MaterialItem object,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  var bytesCount = offsets.last;
  bytesCount += 3 + object.imagePath.length * 3;
  bytesCount += 3 +
      MaterialSpecsSchema.estimateSize(
          object.materialSpecs, allOffsets[MaterialSpecs]!, allOffsets);
  bytesCount += 3 + object.nameKey.length * 3;
  return bytesCount;
}

void _materialItemSerialize(
  MaterialItem object,
  IsarWriter writer,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  writer.writeString(offsets[0], object.imagePath);
  writer.writeBool(offsets[1], object.isPreset);
  writer.writeObject<MaterialSpecs>(
    offsets[2],
    allOffsets,
    MaterialSpecsSchema.serialize,
    object.materialSpecs,
  );
  writer.writeString(offsets[3], object.nameKey);
}

MaterialItem _materialItemDeserialize(
  Id id,
  IsarReader reader,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  final object = MaterialItem();
  object.id = id;
  object.imagePath = reader.readString(offsets[0]);
  object.isPreset = reader.readBool(offsets[1]);
  object.materialSpecs = reader.readObjectOrNull<MaterialSpecs>(
        offsets[2],
        MaterialSpecsSchema.deserialize,
        allOffsets,
      ) ??
      MaterialSpecs();
  object.nameKey = reader.readString(offsets[3]);
  return object;
}

P _materialItemDeserializeProp<P>(
  IsarReader reader,
  int propertyId,
  int offset,
  Map<Type, List<int>> allOffsets,
) {
  switch (propertyId) {
    case 0:
      return (reader.readString(offset)) as P;
    case 1:
      return (reader.readBool(offset)) as P;
    case 2:
      return (reader.readObjectOrNull<MaterialSpecs>(
            offset,
            MaterialSpecsSchema.deserialize,
            allOffsets,
          ) ??
          MaterialSpecs()) as P;
    case 3:
      return (reader.readString(offset)) as P;
    default:
      throw IsarError('Unknown property with id $propertyId');
  }
}

Id _materialItemGetId(MaterialItem object) {
  return object.id;
}

List<IsarLinkBase<dynamic>> _materialItemGetLinks(MaterialItem object) {
  return [];
}

void _materialItemAttach(
    IsarCollection<dynamic> col, Id id, MaterialItem object) {
  object.id = id;
}

extension MaterialItemQueryWhereSort
    on QueryBuilder<MaterialItem, MaterialItem, QWhere> {
  QueryBuilder<MaterialItem, MaterialItem, QAfterWhere> anyId() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(const IdWhereClause.any());
    });
  }
}

extension MaterialItemQueryWhere
    on QueryBuilder<MaterialItem, MaterialItem, QWhereClause> {
  QueryBuilder<MaterialItem, MaterialItem, QAfterWhereClause> idEqualTo(Id id) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IdWhereClause.between(
        lower: id,
        upper: id,
      ));
    });
  }

  QueryBuilder<MaterialItem, MaterialItem, QAfterWhereClause> idNotEqualTo(
      Id id) {
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

  QueryBuilder<MaterialItem, MaterialItem, QAfterWhereClause> idGreaterThan(
      Id id,
      {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.greaterThan(lower: id, includeLower: include),
      );
    });
  }

  QueryBuilder<MaterialItem, MaterialItem, QAfterWhereClause> idLessThan(Id id,
      {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.lessThan(upper: id, includeUpper: include),
      );
    });
  }

  QueryBuilder<MaterialItem, MaterialItem, QAfterWhereClause> idBetween(
    Id lowerId,
    Id upperId, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IdWhereClause.between(
        lower: lowerId,
        includeLower: includeLower,
        upper: upperId,
        includeUpper: includeUpper,
      ));
    });
  }
}

extension MaterialItemQueryFilter
    on QueryBuilder<MaterialItem, MaterialItem, QFilterCondition> {
  QueryBuilder<MaterialItem, MaterialItem, QAfterFilterCondition> idEqualTo(
      Id value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'id',
        value: value,
      ));
    });
  }

  QueryBuilder<MaterialItem, MaterialItem, QAfterFilterCondition> idGreaterThan(
    Id value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'id',
        value: value,
      ));
    });
  }

  QueryBuilder<MaterialItem, MaterialItem, QAfterFilterCondition> idLessThan(
    Id value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'id',
        value: value,
      ));
    });
  }

  QueryBuilder<MaterialItem, MaterialItem, QAfterFilterCondition> idBetween(
    Id lower,
    Id upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'id',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<MaterialItem, MaterialItem, QAfterFilterCondition>
      imagePathEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'imagePath',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<MaterialItem, MaterialItem, QAfterFilterCondition>
      imagePathGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'imagePath',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<MaterialItem, MaterialItem, QAfterFilterCondition>
      imagePathLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'imagePath',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<MaterialItem, MaterialItem, QAfterFilterCondition>
      imagePathBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'imagePath',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<MaterialItem, MaterialItem, QAfterFilterCondition>
      imagePathStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'imagePath',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<MaterialItem, MaterialItem, QAfterFilterCondition>
      imagePathEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'imagePath',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<MaterialItem, MaterialItem, QAfterFilterCondition>
      imagePathContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'imagePath',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<MaterialItem, MaterialItem, QAfterFilterCondition>
      imagePathMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'imagePath',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<MaterialItem, MaterialItem, QAfterFilterCondition>
      imagePathIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'imagePath',
        value: '',
      ));
    });
  }

  QueryBuilder<MaterialItem, MaterialItem, QAfterFilterCondition>
      imagePathIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'imagePath',
        value: '',
      ));
    });
  }

  QueryBuilder<MaterialItem, MaterialItem, QAfterFilterCondition>
      isPresetEqualTo(bool value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'isPreset',
        value: value,
      ));
    });
  }

  QueryBuilder<MaterialItem, MaterialItem, QAfterFilterCondition>
      nameKeyEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'nameKey',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<MaterialItem, MaterialItem, QAfterFilterCondition>
      nameKeyGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'nameKey',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<MaterialItem, MaterialItem, QAfterFilterCondition>
      nameKeyLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'nameKey',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<MaterialItem, MaterialItem, QAfterFilterCondition>
      nameKeyBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'nameKey',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<MaterialItem, MaterialItem, QAfterFilterCondition>
      nameKeyStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'nameKey',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<MaterialItem, MaterialItem, QAfterFilterCondition>
      nameKeyEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'nameKey',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<MaterialItem, MaterialItem, QAfterFilterCondition>
      nameKeyContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'nameKey',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<MaterialItem, MaterialItem, QAfterFilterCondition>
      nameKeyMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'nameKey',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<MaterialItem, MaterialItem, QAfterFilterCondition>
      nameKeyIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'nameKey',
        value: '',
      ));
    });
  }

  QueryBuilder<MaterialItem, MaterialItem, QAfterFilterCondition>
      nameKeyIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'nameKey',
        value: '',
      ));
    });
  }
}

extension MaterialItemQueryObject
    on QueryBuilder<MaterialItem, MaterialItem, QFilterCondition> {
  QueryBuilder<MaterialItem, MaterialItem, QAfterFilterCondition> materialSpecs(
      FilterQuery<MaterialSpecs> q) {
    return QueryBuilder.apply(this, (query) {
      return query.object(q, r'materialSpecs');
    });
  }
}

extension MaterialItemQueryLinks
    on QueryBuilder<MaterialItem, MaterialItem, QFilterCondition> {}

extension MaterialItemQuerySortBy
    on QueryBuilder<MaterialItem, MaterialItem, QSortBy> {
  QueryBuilder<MaterialItem, MaterialItem, QAfterSortBy> sortByImagePath() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'imagePath', Sort.asc);
    });
  }

  QueryBuilder<MaterialItem, MaterialItem, QAfterSortBy> sortByImagePathDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'imagePath', Sort.desc);
    });
  }

  QueryBuilder<MaterialItem, MaterialItem, QAfterSortBy> sortByIsPreset() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isPreset', Sort.asc);
    });
  }

  QueryBuilder<MaterialItem, MaterialItem, QAfterSortBy> sortByIsPresetDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isPreset', Sort.desc);
    });
  }

  QueryBuilder<MaterialItem, MaterialItem, QAfterSortBy> sortByNameKey() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'nameKey', Sort.asc);
    });
  }

  QueryBuilder<MaterialItem, MaterialItem, QAfterSortBy> sortByNameKeyDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'nameKey', Sort.desc);
    });
  }
}

extension MaterialItemQuerySortThenBy
    on QueryBuilder<MaterialItem, MaterialItem, QSortThenBy> {
  QueryBuilder<MaterialItem, MaterialItem, QAfterSortBy> thenById() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.asc);
    });
  }

  QueryBuilder<MaterialItem, MaterialItem, QAfterSortBy> thenByIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.desc);
    });
  }

  QueryBuilder<MaterialItem, MaterialItem, QAfterSortBy> thenByImagePath() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'imagePath', Sort.asc);
    });
  }

  QueryBuilder<MaterialItem, MaterialItem, QAfterSortBy> thenByImagePathDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'imagePath', Sort.desc);
    });
  }

  QueryBuilder<MaterialItem, MaterialItem, QAfterSortBy> thenByIsPreset() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isPreset', Sort.asc);
    });
  }

  QueryBuilder<MaterialItem, MaterialItem, QAfterSortBy> thenByIsPresetDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isPreset', Sort.desc);
    });
  }

  QueryBuilder<MaterialItem, MaterialItem, QAfterSortBy> thenByNameKey() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'nameKey', Sort.asc);
    });
  }

  QueryBuilder<MaterialItem, MaterialItem, QAfterSortBy> thenByNameKeyDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'nameKey', Sort.desc);
    });
  }
}

extension MaterialItemQueryWhereDistinct
    on QueryBuilder<MaterialItem, MaterialItem, QDistinct> {
  QueryBuilder<MaterialItem, MaterialItem, QDistinct> distinctByImagePath(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'imagePath', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<MaterialItem, MaterialItem, QDistinct> distinctByIsPreset() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'isPreset');
    });
  }

  QueryBuilder<MaterialItem, MaterialItem, QDistinct> distinctByNameKey(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'nameKey', caseSensitive: caseSensitive);
    });
  }
}

extension MaterialItemQueryProperty
    on QueryBuilder<MaterialItem, MaterialItem, QQueryProperty> {
  QueryBuilder<MaterialItem, int, QQueryOperations> idProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'id');
    });
  }

  QueryBuilder<MaterialItem, String, QQueryOperations> imagePathProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'imagePath');
    });
  }

  QueryBuilder<MaterialItem, bool, QQueryOperations> isPresetProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'isPreset');
    });
  }

  QueryBuilder<MaterialItem, MaterialSpecs, QQueryOperations>
      materialSpecsProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'materialSpecs');
    });
  }

  QueryBuilder<MaterialItem, String, QQueryOperations> nameKeyProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'nameKey');
    });
  }
}

// **************************************************************************
// IsarEmbeddedGenerator
// **************************************************************************

// coverage:ignore-file
// ignore_for_file: duplicate_ignore, non_constant_identifier_names, constant_identifier_names, invalid_use_of_protected_member, unnecessary_cast, prefer_const_constructors, lines_longer_than_80_chars, require_trailing_commas, inference_failure_on_function_invocation, unnecessary_parenthesis, unnecessary_raw_strings, unnecessary_null_checks, join_return_with_assignment, prefer_final_locals, avoid_js_rounded_ints, avoid_positional_boolean_parameters, always_specify_types

const MaterialSpecsSchema = Schema(
  name: r'MaterialSpecs',
  id: -6580784389303216347,
  properties: {
    r'chipLoad': PropertySchema(
      id: 0,
      name: r'chipLoad',
      type: IsarType.doubleList,
    ),
    r'cutSpeedCarbide': PropertySchema(
      id: 1,
      name: r'cutSpeedCarbide',
      type: IsarType.long,
    ),
    r'cutSpeedHss': PropertySchema(
      id: 2,
      name: r'cutSpeedHss',
      type: IsarType.long,
    ),
    r'depth': PropertySchema(
      id: 3,
      name: r'depth',
      type: IsarType.longList,
    ),
    r'depthPerPass': PropertySchema(
      id: 4,
      name: r'depthPerPass',
      type: IsarType.doubleList,
    )
  },
  estimateSize: _materialSpecsEstimateSize,
  serialize: _materialSpecsSerialize,
  deserialize: _materialSpecsDeserialize,
  deserializeProp: _materialSpecsDeserializeProp,
);

int _materialSpecsEstimateSize(
  MaterialSpecs object,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  var bytesCount = offsets.last;
  bytesCount += 3 + object.chipLoad.length * 8;
  bytesCount += 3 + object.depth.length * 8;
  bytesCount += 3 + object.depthPerPass.length * 8;
  return bytesCount;
}

void _materialSpecsSerialize(
  MaterialSpecs object,
  IsarWriter writer,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  writer.writeDoubleList(offsets[0], object.chipLoad);
  writer.writeLong(offsets[1], object.cutSpeedCarbide);
  writer.writeLong(offsets[2], object.cutSpeedHss);
  writer.writeLongList(offsets[3], object.depth);
  writer.writeDoubleList(offsets[4], object.depthPerPass);
}

MaterialSpecs _materialSpecsDeserialize(
  Id id,
  IsarReader reader,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  final object = MaterialSpecs();
  object.chipLoad = reader.readDoubleList(offsets[0]) ?? [];
  object.cutSpeedCarbide = reader.readLong(offsets[1]);
  object.cutSpeedHss = reader.readLong(offsets[2]);
  object.depth = reader.readLongList(offsets[3]) ?? [];
  object.depthPerPass = reader.readDoubleList(offsets[4]) ?? [];
  return object;
}

P _materialSpecsDeserializeProp<P>(
  IsarReader reader,
  int propertyId,
  int offset,
  Map<Type, List<int>> allOffsets,
) {
  switch (propertyId) {
    case 0:
      return (reader.readDoubleList(offset) ?? []) as P;
    case 1:
      return (reader.readLong(offset)) as P;
    case 2:
      return (reader.readLong(offset)) as P;
    case 3:
      return (reader.readLongList(offset) ?? []) as P;
    case 4:
      return (reader.readDoubleList(offset) ?? []) as P;
    default:
      throw IsarError('Unknown property with id $propertyId');
  }
}

extension MaterialSpecsQueryFilter
    on QueryBuilder<MaterialSpecs, MaterialSpecs, QFilterCondition> {
  QueryBuilder<MaterialSpecs, MaterialSpecs, QAfterFilterCondition>
      chipLoadElementEqualTo(
    double value, {
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'chipLoad',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<MaterialSpecs, MaterialSpecs, QAfterFilterCondition>
      chipLoadElementGreaterThan(
    double value, {
    bool include = false,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'chipLoad',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<MaterialSpecs, MaterialSpecs, QAfterFilterCondition>
      chipLoadElementLessThan(
    double value, {
    bool include = false,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'chipLoad',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<MaterialSpecs, MaterialSpecs, QAfterFilterCondition>
      chipLoadElementBetween(
    double lower,
    double upper, {
    bool includeLower = true,
    bool includeUpper = true,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'chipLoad',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<MaterialSpecs, MaterialSpecs, QAfterFilterCondition>
      chipLoadLengthEqualTo(int length) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'chipLoad',
        length,
        true,
        length,
        true,
      );
    });
  }

  QueryBuilder<MaterialSpecs, MaterialSpecs, QAfterFilterCondition>
      chipLoadIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'chipLoad',
        0,
        true,
        0,
        true,
      );
    });
  }

  QueryBuilder<MaterialSpecs, MaterialSpecs, QAfterFilterCondition>
      chipLoadIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'chipLoad',
        0,
        false,
        999999,
        true,
      );
    });
  }

  QueryBuilder<MaterialSpecs, MaterialSpecs, QAfterFilterCondition>
      chipLoadLengthLessThan(
    int length, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'chipLoad',
        0,
        true,
        length,
        include,
      );
    });
  }

  QueryBuilder<MaterialSpecs, MaterialSpecs, QAfterFilterCondition>
      chipLoadLengthGreaterThan(
    int length, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'chipLoad',
        length,
        include,
        999999,
        true,
      );
    });
  }

  QueryBuilder<MaterialSpecs, MaterialSpecs, QAfterFilterCondition>
      chipLoadLengthBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'chipLoad',
        lower,
        includeLower,
        upper,
        includeUpper,
      );
    });
  }

  QueryBuilder<MaterialSpecs, MaterialSpecs, QAfterFilterCondition>
      cutSpeedCarbideEqualTo(int value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'cutSpeedCarbide',
        value: value,
      ));
    });
  }

  QueryBuilder<MaterialSpecs, MaterialSpecs, QAfterFilterCondition>
      cutSpeedCarbideGreaterThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'cutSpeedCarbide',
        value: value,
      ));
    });
  }

  QueryBuilder<MaterialSpecs, MaterialSpecs, QAfterFilterCondition>
      cutSpeedCarbideLessThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'cutSpeedCarbide',
        value: value,
      ));
    });
  }

  QueryBuilder<MaterialSpecs, MaterialSpecs, QAfterFilterCondition>
      cutSpeedCarbideBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'cutSpeedCarbide',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<MaterialSpecs, MaterialSpecs, QAfterFilterCondition>
      cutSpeedHssEqualTo(int value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'cutSpeedHss',
        value: value,
      ));
    });
  }

  QueryBuilder<MaterialSpecs, MaterialSpecs, QAfterFilterCondition>
      cutSpeedHssGreaterThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'cutSpeedHss',
        value: value,
      ));
    });
  }

  QueryBuilder<MaterialSpecs, MaterialSpecs, QAfterFilterCondition>
      cutSpeedHssLessThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'cutSpeedHss',
        value: value,
      ));
    });
  }

  QueryBuilder<MaterialSpecs, MaterialSpecs, QAfterFilterCondition>
      cutSpeedHssBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'cutSpeedHss',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<MaterialSpecs, MaterialSpecs, QAfterFilterCondition>
      depthElementEqualTo(int value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'depth',
        value: value,
      ));
    });
  }

  QueryBuilder<MaterialSpecs, MaterialSpecs, QAfterFilterCondition>
      depthElementGreaterThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'depth',
        value: value,
      ));
    });
  }

  QueryBuilder<MaterialSpecs, MaterialSpecs, QAfterFilterCondition>
      depthElementLessThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'depth',
        value: value,
      ));
    });
  }

  QueryBuilder<MaterialSpecs, MaterialSpecs, QAfterFilterCondition>
      depthElementBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'depth',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<MaterialSpecs, MaterialSpecs, QAfterFilterCondition>
      depthLengthEqualTo(int length) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'depth',
        length,
        true,
        length,
        true,
      );
    });
  }

  QueryBuilder<MaterialSpecs, MaterialSpecs, QAfterFilterCondition>
      depthIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'depth',
        0,
        true,
        0,
        true,
      );
    });
  }

  QueryBuilder<MaterialSpecs, MaterialSpecs, QAfterFilterCondition>
      depthIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'depth',
        0,
        false,
        999999,
        true,
      );
    });
  }

  QueryBuilder<MaterialSpecs, MaterialSpecs, QAfterFilterCondition>
      depthLengthLessThan(
    int length, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'depth',
        0,
        true,
        length,
        include,
      );
    });
  }

  QueryBuilder<MaterialSpecs, MaterialSpecs, QAfterFilterCondition>
      depthLengthGreaterThan(
    int length, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'depth',
        length,
        include,
        999999,
        true,
      );
    });
  }

  QueryBuilder<MaterialSpecs, MaterialSpecs, QAfterFilterCondition>
      depthLengthBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'depth',
        lower,
        includeLower,
        upper,
        includeUpper,
      );
    });
  }

  QueryBuilder<MaterialSpecs, MaterialSpecs, QAfterFilterCondition>
      depthPerPassElementEqualTo(
    double value, {
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'depthPerPass',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<MaterialSpecs, MaterialSpecs, QAfterFilterCondition>
      depthPerPassElementGreaterThan(
    double value, {
    bool include = false,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'depthPerPass',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<MaterialSpecs, MaterialSpecs, QAfterFilterCondition>
      depthPerPassElementLessThan(
    double value, {
    bool include = false,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'depthPerPass',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<MaterialSpecs, MaterialSpecs, QAfterFilterCondition>
      depthPerPassElementBetween(
    double lower,
    double upper, {
    bool includeLower = true,
    bool includeUpper = true,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'depthPerPass',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<MaterialSpecs, MaterialSpecs, QAfterFilterCondition>
      depthPerPassLengthEqualTo(int length) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'depthPerPass',
        length,
        true,
        length,
        true,
      );
    });
  }

  QueryBuilder<MaterialSpecs, MaterialSpecs, QAfterFilterCondition>
      depthPerPassIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'depthPerPass',
        0,
        true,
        0,
        true,
      );
    });
  }

  QueryBuilder<MaterialSpecs, MaterialSpecs, QAfterFilterCondition>
      depthPerPassIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'depthPerPass',
        0,
        false,
        999999,
        true,
      );
    });
  }

  QueryBuilder<MaterialSpecs, MaterialSpecs, QAfterFilterCondition>
      depthPerPassLengthLessThan(
    int length, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'depthPerPass',
        0,
        true,
        length,
        include,
      );
    });
  }

  QueryBuilder<MaterialSpecs, MaterialSpecs, QAfterFilterCondition>
      depthPerPassLengthGreaterThan(
    int length, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'depthPerPass',
        length,
        include,
        999999,
        true,
      );
    });
  }

  QueryBuilder<MaterialSpecs, MaterialSpecs, QAfterFilterCondition>
      depthPerPassLengthBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'depthPerPass',
        lower,
        includeLower,
        upper,
        includeUpper,
      );
    });
  }
}

extension MaterialSpecsQueryObject
    on QueryBuilder<MaterialSpecs, MaterialSpecs, QFilterCondition> {}
