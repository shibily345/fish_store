import 'package:betta_store/core/core/errors/failure.dart';
import 'package:betta_store/core/core/params/params.dart';
import 'package:dartz/dartz.dart';
import '../entities/template_entity.dart';
import '../repositories/template_repository.dart';

class GetTemplate {
  final TemplateRepository templateRepository;

  GetTemplate({required this.templateRepository});

  Future<Either<Failure, TemplateEntity>> call({
    required TemplateParams templateParams,
  }) async {
    return await templateRepository.getTemplate(templateParams: templateParams);
  }
}
