/**
 * @module Services
 * 
 * @param {cds.Service} srv 
 */
module.exports = (srv) => {
  const { Paddocks, Cattles, Locations } = srv.entities;

  srv.before(['CREATE', 'UPDATE'], Paddocks, async req => {
    const { location, acres, maxCattle } = req.data;

    if (!location) req.error(400, `'location' is a mandatory field`);
    if (!acres) req.error(400, `'acres' is a mandatory field`);
    if (!maxCattle) req.error(400, `'maxCattle' is a mandatory field`);
  });

  srv.after(['READ'], Paddocks, async (paddocks, req) => {
    const paddocksByID = paddocks.reduce((all, o) => { (all[o.ID] = o).numberOfCattle = 0; return all }, {});
    const query = SELECT.from(Cattles).columns('paddock_ID', 'count(paddock_ID)')
      .where({ paddock_ID: { in: Object.keys(paddocksByID) } })
      .groupBy('paddock_ID');

    return cds.transaction(req).run(query).then(cattles => cattles.forEach(cattle => {
      const paddock = paddocksByID[cattle.paddock_ID];
      paddock.numberOfCattle = cattle[ 'count ( paddock_ID )']
    }))
  });

  srv.before(['UPDATE', 'CREATE'], Cattles, async req => {
    const { ID: cattle_ID, paddock_ID } = req.data;

    if(!(cattle_ID && paddock_ID)) return;
    await cds.transaction(req).run(
      INSERT.into(Locations).entries([{cattle_ID, paddock_ID}])
    );
  });
};