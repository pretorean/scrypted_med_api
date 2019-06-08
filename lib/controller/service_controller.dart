import 'package:scrypted_med_api/model/service.dart';
import 'package:scrypted_med_api/repository/service_repository.dart';

import '../scrypted_med_api.dart';

class ServiceController extends ResourceController {
  ServiceController(this.context) {
    repository = ServiceRepository(context);
  }

  final ManagedContext context;
  ServiceRepository repository;

  @Operation.get('orgId')
  Future<Response> getAll(@Bind.path('orgId') int orgId) async {
    final list = await repository.getServiceByOrgId(orgId);
    return Response.ok(list);
  }

  @Operation.get('orgId', 'servId')
  Future<Response> getItemById(
      @Bind.path("orgId") int orgId, @Bind.path("servId") int servId) async {
    final company = await repository.getServiceById(orgId, servId);

    if (company == null) {
      return Response.notFound();
    }

    return Response.ok(company);
  }

  @Operation.post('orgId')
  Future<Response> createItem(
      @Bind.path("orgId") int orgId, @Bind.body() Service serv) async {
    final newOrg = await repository.createService(orgId, serv);
    return Response.ok(newOrg);
  }

  @Operation.put('orgId', 'servId')
  Future<Response> updateItem(@Bind.path("orgId") int orgId,
      @Bind.path("servId") int servId, @Bind.body() Service serv) async {
    final tmpOrg = await repository.setService(orgId, servId, serv);
    if (tmpOrg == null) {
      return Response.notFound();
    } else {
      return Response.ok(tmpOrg);
    }
  }

  @Operation.delete('orgId', 'servId')
  Future<Response> deleteItem(
      @Bind.path("orgId") int orgId, @Bind.path("servId") int servId) async {
    final count = await repository.deleteService(orgId, servId);
    if (count == 0) {
      return Response.notFound();
    } else {
      return Response.ok({"deleted": "$count"});
    }
  }
}
