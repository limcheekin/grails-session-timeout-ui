grails.project.work.dir = 'target'

grails.project.dependency.resolver = 'maven'
grails.project.dependency.resolution = {

    inherits 'global'
    log 'warn'

    repositories {
        grailsCentral()
        mavenLocal()
        mavenCentral()
    }

    plugins {
        runtime ':gsp-resources:0.4.4'
        runtime ':resources:1.2.13'

        build ':release:3.0.1', ':rest-client-builder:2.0.3', {
            export = false
        }
    }
}
