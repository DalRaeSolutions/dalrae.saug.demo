const request = require('supertest')
const app = require('express')()
const cds = require('@sap/cds')


const logLevel = 'error' //'info'

beforeAll(async () => {
  await cds.connect({ kind: 'sqlite', database: ':memory:' })
  const csn = await cds.load('srv')
  await cds.deploy(csn)
  await cds.serve('all', { logLevel }).in(app)
})

afterAll(async () => {
  await cds.disconnect()
});

describe('CattleService', () => {
  beforeEach(async () => {
    await Promise.all([
      cds.run(DELETE.from('dalrae.saug.demo.Paddocks')),
      cds.run(DELETE.from('dalrae.saug.demo.Cattles'))
    ])
    await Promise.all([
      cds.run(INSERT.into('dalrae.saug.demo.Paddocks').columns(
        'ID', 'location', 'acres', 'maxCattle'
      ).rows(
        ['8caf60df-618b-4abe-861f-ea52f39d5eff', 'North', 2000, 7],
        ['c1803f38-9fd7-4485-bc03-adf48ad9a7ee', 'West', 750, 3]
      )),
      cds.run(INSERT.into('dalrae.saug.demo.Cattles').columns(
        'ID', 'paddock_ID', 'name', 'gender'
      ).rows(
        ['4d73f359-6182-4612-a8ad-8bedcfa77e88', '8caf60df-618b-4abe-861f-ea52f39d5eff', 'Cow 1', 'F'],
        ['520e26dc-be7b-48c2-85e3-b14013c25f3a', '8caf60df-618b-4abe-861f-ea52f39d5eff', 'Cow 2', 'F'],
        ['e517ca1b-0c92-4306-9502-736f5e429f58', '8caf60df-618b-4abe-861f-ea52f39d5eff', 'Cow 3', 'F'],
        ['008943ac-6dde-47fe-80d5-854257771966', '8caf60df-618b-4abe-861f-ea52f39d5eff', 'Cow 4', 'F'],
        ['455ca5bb-baaa-4060-8011-1d1da9a67e5b', 'c1803f38-9fd7-4485-bc03-adf48ad9a7ee', 'Cow 5', 'F'],
        ['b3238100-a607-40ba-8527-5457bd9ab6ab', 'c1803f38-9fd7-4485-bc03-adf48ad9a7ee', 'Cow 6', 'F'],
        ['464cdd97-1b3f-4199-9e93-13ad35467e28', 'c1803f38-9fd7-4485-bc03-adf48ad9a7ee', 'Cow 7', 'F'],
        ['89f3615a-1d49-4585-8d8b-605ab93137ca', 'c1803f38-9fd7-4485-bc03-adf48ad9a7ee', 'Cow 8', 'F'],
        ['62b6414b-fe6a-415c-ad73-0f157022a4ea', 'c1803f38-9fd7-4485-bc03-adf48ad9a7ee', 'Bull 1', 'M'],
        ['a3ec85ac-1b6e-42f4-9e91-0448b293ac8f', 'c1803f38-9fd7-4485-bc03-adf48ad9a7ee', 'Bull 2', 'M']
      )),
    ])
  });

  it('has the correct entities', async () => {
    const result = await request(app).get('/cattle');

    expect(result.body.value).toContainEqual({ name: "Paddocks", url: "Paddocks" });
    expect(result.body.value).toContainEqual({ name: "Cattles", url: "Cattles" });
    expect(result.body.value.length).toEqual(2);
  })


  it('has metadata', async () => {
    const result = await request(app).get('/cattle/$metadata');

    expect(result.text.includes('<edmx:Edmx Version="4.0" xmlns:edmx="http://docs.oasis-open.org/odata/ns/edmx">')).toEqual(true)
  });

  describe('has an entity for Paddocks', () => {

    it('can fetch a list of Paddocks', async () => {
      const result = await request(app).get('/cattle/Paddocks');

      expect(result.statusCode).toEqual(200);
      expect(Object.keys(result.body).includes('@odata.context')).toEqual(true);
      expect(result.body['@odata.context']).toEqual('$metadata#Paddocks');
      expect(result.body.value.length).toEqual(2);

      expect(result.body.value).toContainEqual(
        expect.objectContaining({
          ID: 'c1803f38-9fd7-4485-bc03-adf48ad9a7ee',
          location: 'West',
          acres: 750,
          maxCattle: 3,
          numberOfCattle: expect.any(Number),
          createdAt: expect.any(String),
          modifiedAt: expect.any(String),
          createdBy: expect.any(String),
          modifiedBy: expect.any(String)
        })
      )
    });

    it('can create a Paddock', async () => {
      const result = await request(app).post('/cattle/Paddocks').send({
        location: 'East',
        acres: 400,
        maxCattle: 5
      });

      console.log(result.body)

      expect(result.statusCode).toEqual(201);

      expect(result.body.value).toContainEqual(
        expect.objectContaining({
          '@odata.context': '$metadata#Paddocks/$entity',
          ID: expect.any(String),
          location: 'East',
          acres: 400,
          maxCattle: 5,
          numberOfCattle: expect.any(Number),
          createdAt: expect.any(String),
          modifiedAt: expect.any(String),
          createdBy: expect.any(String),
          modifiedBy: expect.any(String)
        })
      )
    });

  });
})