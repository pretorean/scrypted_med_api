import 'package:scrypted_med_api/model/organization.dart';

import '../scrypted_med_api.dart';

class OrganizationRepository {
  OrganizationRepository(this.context);

  final ManagedContext context;

  Future<List<Organization>> getAllCompanyList(
      int count, String query, int region) async {
    final q = Query<Organization>(context)
      ..where((i) => i.deleted).equalTo(false)
      ..fetchLimit = count;

    if (region != null) {
      q.where((i) => i.region).equalTo(region);
    }

    if (query != null && query.isNotEmpty) {
      query.split(' ').forEach((String s) {
        q.predicate = QueryPredicate(
            "(name ~~* @name OR fullName ~~* @fullName OR address ~~* @address OR chiefName ~~* @chiefName)",
            {
              'name': '%$s%',
              'fullName': '%$s%',
              'address': '%$s%',
              'chiefName': '%$s%'
            });
      });
    }

    return q.fetch();
  }

  Future<Organization> getCompanyById(int orgId) async {
    final q = Query<Organization>(context)
      ..where((c) => c.id).equalTo(orgId)
      ..where((i) => i.deleted).equalTo(false);
    return q.fetchOne();
  }

  Future<Organization> createOrganization(Organization org) {
    final q = Query<Organization>(context)..values = org;
    return q.insert();
  }

  Future<Organization> setOrganization(int orgId, Organization org) async {
    final q = Query<Organization>(context)
      ..values = org
      ..where((i) => i.id).equalTo(orgId);
    return q.updateOne();
  }

  Future<int> deleteOrganization(int orgId) async {
    final query = Query<Organization>(context)
      ..values.deleted = true
      ..where((i) => i.id).equalTo(orgId);
    final p = await query.updateOne();
    return p != null ? 1 : 0;
  }
}
