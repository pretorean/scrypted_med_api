import 'package:scrypted_med_api/model/organization.dart';
import 'package:scrypted_med_api/repository/organization_repository.dart';

import '../scrypted_med_api.dart';

class OrganizationController extends ResourceController {
  OrganizationController(this.context) {
    repository = OrganizationRepository(context);
  }

  final ManagedContext context;
  OrganizationRepository repository;

  @Operation.get()
  Future<Response> getAll() async {
    final companyList = await repository.getAllCompanyList();
    return Response.ok(companyList);
  }

  @Operation.get("id")
  Future<Response> getItemById(@Bind.path("id") int id) async {
    final company = await repository.getCompanyById(id);

    if (company == null) {
      return Response.notFound();
    }

    return Response.ok(company);
  }

  @Operation.post()
  Future<Response> createItem({@Bind.body() Organization org}) async {
    final newOrg = await repository.createOrganization(org);
    return Response.ok(newOrg);
  }

  @Operation.put("id")
  Future<Response> updateItem(
      @Bind.path("id") int orgId, @Bind.body() Organization org) async {
    final tmpOrg = await repository.setOrganization(orgId, org);
    if (tmpOrg == null)
      return Response.notFound();
    else
      return Response.ok(tmpOrg);
  }

  @Operation.delete("id")
  Future<Response> deleteItem(@Bind.path("id") int orgId) async {
    final count = await repository.deleteOrganization(orgId);
    if (count == 0)
      return Response.notFound();
    else
      return Response.ok({"deleted": "$count"});
  }
}
