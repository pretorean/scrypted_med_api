import 'package:scrypted_med_api/model/service.dart';

import '../scrypted_med_api.dart';

class Organization extends ManagedObject<_Organization>
    implements _Organization {
  @override
  void willInsert() {
    createdAt = DateTime.now().toUtc();
    updatedAt = DateTime.now().toUtc();
  }

  @override
  void willUpdate() {
    updatedAt = DateTime.now().toUtc();
  }
}

@Table(name: 'organization')
class _Organization {
  @primaryKey
  int id;

  @Column(indexed: true)
  String name; //  Краткое наименование учреждения

  @Column(indexed: true, nullable: true)
  String fullName; //  Полное наименование учреждения

  @Column(indexed: true, nullable: true)
  double lat; // широта;

  @Column(indexed: true, nullable: true)
  double lng; // долгота;

  @Column(indexed: true, nullable: true)
  String orgType; //  Тип объекта	Дом ребенка

  @Column(indexed: true, nullable: true)
  String address;

//  Район	Каменск-Шахтинский
//  Индекс	347809
//  Населенный пункт	г. Каменск-Шахтинский
//  Улица	ул. Украинская
//  Дом	87

  @Column(indexed: true, nullable: true)
  String inn; //  ИНН	6147022090

  @Column(indexed: true, nullable: true)
  String chiefName; //  Ф.И.О. руководителя

  @Column(indexed: true, nullable: true)
  String chiefPhone; //  Телефон руководителя

  @Column(indexed: true, nullable: true)
  String phone; //  Примечания

  @Column(indexed: true, nullable: true)
  String schedule; //  График работы

  @Column(indexed: true, nullable: true)
  String email; //

  @Column(indexed: true, nullable: true)
  String url; //

  @Column(indexed: true, nullable: true)
  int region; //

  @Column(indexed: true, nullable: true)
  String description; //  Примечания

//  Перечень оказываемых услуг	Круглосуточное содержание, воспитание, оказание медицинской и социальной помощи, комплексной медико-психологической и педагогической реабилитации детей от рождения до 4 лет включительно, ост. без попечения родителей

  @Column(indexed: true, defaultValue: "false")
  bool deleted = false;

  DateTime createdAt;
  DateTime updatedAt;

  ManagedSet<Service> service;
}
