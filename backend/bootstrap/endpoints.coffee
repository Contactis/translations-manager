module.exports = (epilogue) ->

  epilogue.resource
    model: orm.Languages
    endpoints: ['/api/language', '/api/language/:id']