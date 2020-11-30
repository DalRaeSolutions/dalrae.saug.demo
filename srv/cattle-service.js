/**
 * @module Services
 * 
 * @param {cds.Service} srv 
 */
module.exports = (srv) => {
  const { Cattles, Locations } = srv.entities;

  srv.before(['CREATE', 'UPDATE'], Cattles, async req => {
    const { cattleName, ID: cattle_ID, paddock_ID } = req.data;

    if (!cattleName) req.error(400, `'cattleName' is a mandatory field`);
    if(!(cattle_ID && paddock_ID)) return;
    await cds.transaction(req).run(
      INSERT.into(Locations).entries([{cattle_ID, paddock_ID}])
    );
  });
};