class SessionTimeoutUiGrailsPlugin {
    // the plugin version
    def version = "1.0"
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
        "grails-app/views/layouts/main.gsp",
        "grails-app/i18n/messages.properties",
        "src/templates/**",
        "web-app/css/**",
        "web-app/images/**",
        "web-app/js/application.js"
    ]

    def title = "Grails Session Timeout UI Plugin - Warns User for Session Timeout" // Headline display name of the plugin
    def author = "Lim Chee Kin"
    def authorEmail = "limcheekin@vobject.com"
    def description = '''\
The plugin enabled the web application prompts a message box prior to session timeout.
'''

    // URL to the plugin's documentation
    def documentation = "http://grails.org/plugin/session-timeout-ui"

    // Extra (optional) plugin metadata

    // License: one of 'APACHE', 'GPL2', 'GPL3'
    def license = "APACHE"

    // Details of company behind the plugin (if there is one)
//    def organization = [ name: "My Company", url: "http://www.my-company.com/" ]

    // Any additional developers beyond the author specified above.
//    def developers = [ [ name: "Joe Bloggs", email: "joe@bloggs.net" ]]

    // Location of the plugin's issue tracker.
    def issueManagement = [ system: "GitHub", url: "http://github.com/limcheekin/grails-session-timeout-ui/issues" ]

    // Online location of the plugin's browseable source code.
    def scm = [ url: "https://github.com/limcheekin/grails-session-timeout-ui/" ]

}
