const cds = require('@sap/cds')
const cors = require('cors')

cds.on('bootstrap', (app) => {
    app.use(cors())

    app.use((req, res, next) => {
		res.setHeader('Access-Control-Allow-Origin', '*')
		next()
	})
})

module.exports = cds.server