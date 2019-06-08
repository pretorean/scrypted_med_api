import 'package:scrypted_med_api/model/service.dart';

import '../scrypted_med_api.dart';

class ServiceRepository {
  ServiceRepository(this.context);

  final ManagedContext context;

  Future<List<Service>> getServiceByOrgId(int orgId) async {
    final q = Query<Service>(context)
      ..where((i) => i.deleted).equalTo(false)
      ..where((i) => i.organization.id).equalTo(orgId);
    return q.fetch();
  }

  Future<Service> getServiceById(int orgId, int servId) async {
    final q = Query<Service>(context)
      ..where((c) => c.id).equalTo(orgId)
      ..where((i) => i.deleted).equalTo(false)
      ..where((i) => i.organization.id).equalTo(orgId);
    return q.fetchOne();
  }

  Future<Service> createService(int orgId, Service serv) async {
    final q = Query<Service>(context)
      ..values = serv
      ..values.organization.id = orgId;
    return q.insert();
  }

  Future<Service> setService(int orgId, int servId, Service serv) async {
    final q = Query<Service>(context)
      ..values = serv
      ..where((i) => i.id).equalTo(servId)
      ..where((i) => i.organization.id).equalTo(orgId);
    return q.updateOne();
  }

  Future<int> deleteService(int orgId, int servId) async {
    final query = Query<Service>(context)
      ..values.deleted = true
      ..where((i) => i.id).equalTo(orgId)
      ..where((i) => i.organization.id).equalTo(orgId);
    final p = await query.updateOne();
    return p != null ? 1 : 0;
  }
}
