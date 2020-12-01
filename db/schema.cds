namespace dalrae.saug.demo;

using { Currency, managed, cuid, sap } from '@sap/cds/common';

entity Paddocks : managed, cuid {
  location: String(100);
  acres: Integer;
  maxCattle: Integer;
  virtual numberOfCattle : Integer;
  cattles: Association to many Cattles on cattles.paddock = $self;
  locations: Association to many Locations on locations.paddock = $self;
}

entity Cattles : managed, cuid {
  cattleName: String(20);
  gender: Association to Gender;
  paddock: Association to Paddocks;
  virtual url: String;
  locations: Association to many Locations on locations.cattle = $self;
}

@cds.odata.valuelist
entity Gender : sap.common.CodeList {
  key code : String(1);
}

entity Locations : managed, cuid {
  timestamp : DateTime default $now;
  cattle: Association to Cattles;
  paddock: Association to Paddocks;
}

//example of XSUAA authorisations altering the queries performend
// extend Paddocks with @(
//   restrict: [
//     { grant: 'READ', where: 'createdBy = $user' },
//     { grant: 'WRITE', to: 'admin' }
//   ]
// );