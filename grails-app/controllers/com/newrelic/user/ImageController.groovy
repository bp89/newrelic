package com.newrelic.user

class ImageController {
    def imageService
    
    def renderImage = {
        def user = User.findByUsername(params.id)
        if (user && user?.profile?.portrait) {
            response.contentLength = user.profile.portrait.length
            response.outputStream.write(user.profile.portrait)
        }
        else {
            response.sendError(404)
        }

    }

    def tiny = {
        if (params.id) {
            def image = imageService.getUserTinyThumbnail(params.id)
            response.contentLength = image.length
            response.outputStream.write(image)
        }
        else {
            response.sendError(404)
        }

    }


}

