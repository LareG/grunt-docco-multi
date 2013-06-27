module.exports = (grunt) ->
  docco = require 'docco'

  grunt.registerMultiTask 'docco', 'Generate multiple linked docs with docco', () ->

    files = this.filesSrc
    if not this.filesSrc or this.filesSrc.length is 0
      grunt.log.warn 'no files to docco.'
      return

    options = this.options()
    options.args = files
    timeout = options.timeout or 500

    # docco is async due to use of mkdir -p
    done = this.async()

    docco.document options

    # todo having now looked at grunt-docco, that seems to work with a callback, but it just does not wash here
    setTimeout () ->
      grunt.log.ok files.length + ' file' + (if files.length is 1 then '' else 's') + ' doccoed.'
      done()
    , timeout
