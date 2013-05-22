###
 * grunt-init-spa
 * https://gruntjs.com/
 *
 * Copyright (c) 2013 excalibur "刘真源", contributors
 * Licensed under the MIT license.
###
'use strict'
module.exports = (grunt)->

	# Constants
	ASSETS_PATH = "assets"
	APP_PATH = "app"
	DIST_PATH = "dist"
	DEV_PATH = "#{ DIST_PATH }/development"
	REL_PATH = "#{ DIST_PATH }/release"
	JS_DEV_PATH = "#{ ASSETS_PATH }/js"
	CSS_DEV_PATH = "#{ ASSETS_PATH }/css"
	TEST_PATH = "test"
	LIBS_PATH = "#{ASSETS_PATH}/libs"
	

	# paths setup - separate as some modules dont process templates correctly
	app_paths = 


		# less sources
		less_dir: 'less'
		less_src: 'css/**/*.less'		

		# -- compiled output --

		

		# css sources
		css_dir: "#{ASSETS_PATH}/css"
		css_src: "#{ASSETS_PATH}/css/**/*.css"

	# init project configuration
	grunt.initConfig
		# Metadata
		pkg:grunt.file.readJSON 'animate.spa.json'
		banner:"/*! <%= pkg.title || pkg.name %> - v<%= pkg.version %> - 
      			<%= grunt.template.today('yyyy-mm-dd') %>\n
      			<%= pkg.homepage ? '* ' + pkg.homepage + '\\n' : '' %>
      			* Copyright (c) <%= grunt.template.today('yyyy') %> <%= pkg.author.name %>;
      			Licensed <%= _.pluck(pkg.licenses, 'type').join(', ') %> */\n"

		# clean Task
		clean:
			files:[DIST_PATH]

	
		
		# less Task
		less:
			base:				
				files: app_paths.less_file
			development:
				expand: true
				cwd: app_paths.less_dir
				src: [app_paths.less_src]
				dest: ASSETS_PATH
				ext: '.css'

		# watch Task
		watch:
			default:
				files: [
					"less/**/*"
				]
				tasks: [
					"less"
					]	
			less: 
				files: [
					"less/**/*"
				]
				tasks: [
					"less"
				]
		# connect Task
		connect:
			base:
				options:
					port:9000
					base:'./build'
					keepalive:true
			test:
				options:
					port:9001
					base:'./test'
		      			


				
		      
		  

	# These plugins provide necessary tasks
	grunt.loadNpmTasks 'grunt-contrib-clean'
	grunt.loadNpmTasks 'grunt-contrib-copy'
	grunt.loadNpmTasks 'grunt-contrib-concat'
	grunt.loadNpmTasks 'grunt-contrib-qunit'
	grunt.loadNpmTasks 'grunt-contrib-watch'
	grunt.loadNpmTasks 'grunt-contrib-less'
	grunt.loadNpmTasks 'grunt-contrib-connect'

	# register default Task
	grunt.registerTask 'default', [
		'clean'
		'less'
	]
