class TimeoutGrailsPlugin {
    // the plugin version
    def version = "0.1"
    // the version or versions of Grails the plugin is designed for
    def grailsVersion = "2.0 > *"
    // the other plugins this plugin depends on
    def dependsOn = [:]
    // resources that are excluded from plugin packaging
    def pluginExcludes = [
        "grails-app/views/error.gsp",
        "grails-app/views/index.gsp",
        "grails-app/views/logout.gsp",
        "grails-app/views/redirect.gsp",
        "grails-app/views/layouts/main.gsp"
    ]

    // TODO Fill in these fields
    def title = "Grails Timeout Plugin" // Headline display name of the plugin
    def author = "Lim Chee Kin"
    def authorEmail = "limcheekin@vobject.com"
    def description = '''\
Brief summary/description of the plugin.
'''

    // URL to the plugin's documentation
    def documentation = "http://grails.org/plugin/timeout"

    // Extra (optional) plugin metadata

    // License: one of 'APACHE', 'GPL2', 'GPL3'
    def license = "APACHE"

    // Details of company behind the plugin (if there is one)
//    def organization = [ name: "My Company", url: "http://www.my-company.com/" ]

    // Any additional developers beyond the author specified above.
//    def developers = [ [ name: "Joe Bloggs", email: "joe@bloggs.net" ]]

    // Location of the plugin's issue tracker.
    def issueManagement = [ system: "GitHub", url: "http://github.com/limcheekin/grails-timeout/issues" ]

    // Online location of the plugin's browseable source code.
    def scm = [ url: "https://github.com/limcheekin/grails-timeout/" ]

}
