package com.newrelic.user

class ErrorController {
    def serverError = { render "Internal server error - please report to the system administrator" }
    def notFound = { render "Page not found" }
    def forbidden = { render "Access is forbidden" }
}
