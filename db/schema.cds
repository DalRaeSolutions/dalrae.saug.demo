namespace dalrae.saug.demo;

using { Currency, managed, cuid, sap } from '@sap/cds/common';

entity Paddocks : managed, cuid {
  location: String(100);
  acres: Integer;
  maxCattle: Integer;
  virtual numberOfCattle : Integer;
  cattles: Association to many Cattles on cattles.paddock = $self;
}

entity Cattles : managed, cuid {
  cattleName: String(20);
  gender: Association to Gender;
  paddock: Association to Paddocks;
}

@cds.odata.valuelist
entity Gender : sap.common.CodeList {
  key code : String(1);
}
