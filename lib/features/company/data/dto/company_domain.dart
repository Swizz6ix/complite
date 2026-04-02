import 'package:complite/features/company/data/dto/company_dto.dart';
import 'package:complite/features/company/data/models/company.dart';

extension CompanyMapper on CompanyDto {
  Company toDomain() {
    return Company(
      id: id, 
      name: name, 
      country: country, 
      address: address, 
      employeeCount: employeeCount, 
      industry: industry, 
      domain: domain, 
      logo: logo, 
      ceoName: ceoName, 
      zip: zip
    );
  }
}

extension CompanyDomainMapper on Company {
  CompanyDto toDto() {
    return CompanyDto(
      id: id, 
      name: name, 
      country: country, 
      address: address, 
      employeeCount: employeeCount, 
      industry: industry, 
      domain: domain, 
      logo: logo, 
      ceoName: ceoName, 
      zip: zip
    );
  }
}