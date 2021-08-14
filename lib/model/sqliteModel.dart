import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:sqfentity/sqfentity.dart';
import 'package:sqfentity_gen/sqfentity_gen.dart';

part 'sqliteModel.g.dart';

const accountTable = SqfEntityTable(tableName: 'photo', fields: [
  SqfEntityField('id', DbType.integer, isPrimaryKeyField: true),
]);

const seqIdentity = SqfEntitySequence(
  sequenceName: 'identity',
);

@SqfEntityBuilder(dbModel)
const dbModel = SqfEntityModel(
    modelName: 'AwesomeDBModel',
    databaseName: 'awesome.db',
    databaseTables: [],
    sequences: [seqIdentity],
    bundledDatabasePath: null);
