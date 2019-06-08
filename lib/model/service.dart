import 'package:scrypted_med_api/model/organization.dart';

import '../scrypted_med_api.dart';

class Service extends ManagedObject<_Service> implements _Service {
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

@Table(name: 'service')
class _Service {
  @primaryKey
  int id;

  // ссылка на организацию
  @Relate(#service, isRequired: true, onDelete: DeleteRule.cascade)
  Organization organization;

  @Column(indexed: true)
  String name; // наименование услуги

  @Column(indexed: true, nullable: true)
  double price; //  стоимость

  @Column(indexed: true, nullable: true)
  bool availableInsurance; // доступно по страховке;

  @Column(indexed: true, nullable: true)
  bool availableCommercial; // доступно платно;

  @Column(indexed: true, nullable: true)
  String description; //  Примечания

  @Column(indexed: true, defaultValue: "false")
  bool deleted = false;

  DateTime createdAt;
  DateTime updatedAt;
}
