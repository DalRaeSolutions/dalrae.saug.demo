using { dalrae.saug.demo as schema } from '../db/schema';
service PaddockService @(path: '/paddocks') {
  entity Paddocks as projection on schema.Paddocks;
  entity Cattles as projection on schema.Cattles order by cattleName asc;
  @readonly entity Locations as projection on schema.Locations {
    *,
    paddock.location as location,
    cattle.cattleName as cattleName
  } order by timestamp desc;
}