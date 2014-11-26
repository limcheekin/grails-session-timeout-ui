class SessionTimeoutUiGrailsPlugin {
    def version = "1.0"
    def grailsVersion = "2.0 > *"
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

    def title = "Grails Session Timeout UI Plugin - Warns User for Session Timeout"
    def author = "Lim Chee Kin"
    def authorEmail = "limcheekin@vobject.com"
    def description = 'Enables the web application prompts a message box prior to session timeout'
    def documentation = "http://grails.org/plugin/session-timeout-ui"
    def license = "APACHE"
    def issueManagement = [ system: "GitHub", url: "http://github.com/limcheekin/grails-session-timeout-ui/issues" ]
    def scm = [ url: "https://github.com/limcheekin/grails-session-timeout-ui/" ]
}
