

package com.newrelic.user

class ProfileController {
    
    def index = { redirect(action:list,params:params) }

    // the delete, save and update actions only accept POST requests
    static allowedMethods = [delete:'POST', save:'POST', update:'POST']

    def list = {
        params.max = Math.min( params.max ? params.max.toInteger() : 10,  100)
        [ profileInstanceList: Profile.list( params ), profileInstanceTotal: Profile.count() ]
    }

    def show = {
        def profileInstance = Profile.get( params.id )

        if(!profileInstance) {
            flash.message = "Profile not found with id ${params.id}"
            redirect(action:list)
        }
        else { return [ profileInstance : profileInstance ] }
    }

    def delete = {
        def profileInstance = Profile.get( params.id )
        if(profileInstance) {
            try {
                profileInstance.delete(flush:true)
                flash.message = "Profile ${params.id} deleted"
                redirect(action:list)
            }
            catch(org.springframework.dao.DataIntegrityViolationException e) {
                flash.message = "Profile ${params.id} could not be deleted"
                redirect(action:show,id:params.id)
            }
        }
        else {
            flash.message = "Profile not found with id ${params.id}"
            redirect(action:list)
        }
    }

    def edit = {
        def profileInstance = Profile.get( params.id )

        if(!profileInstance) {
            flash.message = "Profile not found with id ${params.id}"
            redirect(action:list)
        }
        else {
            return [ profileInstance : profileInstance ]
        }
    }

    def update = {
        def profileInstance = Profile.get( params.id )
        if(profileInstance) {
            if(params.version) {
                def version = params.version.toLong()
                if(profileInstance.version > version) {
                    
                    profileInstance.errors.rejectValue("version", "profile.optimistic.locking.failure", "Another user has updated this Profile while you were editing.")
                    render(view:'edit',model:[profileInstance:profileInstance])
                    return
                }
            }
            profileInstance.properties = params
            if(!profileInstance.hasErrors() && profileInstance.save()) {
                flash.message = "Profile ${params.id} updated"
                redirect(action:show,id:profileInstance.id)
            }
            else {
                render(view:'edit',model:[profileInstance:profileInstance])
            }
        }
        else {
            flash.message = "Profile not found with id ${params.id}"
            redirect(action:list)
        }
    }

    def create = {
        def profileInstance = new Profile()
        profileInstance.properties = params
        return ['profileInstance':profileInstance]
    }

    def save = {
        def profileInstance = new Profile(params)
        if(!profileInstance.hasErrors() && profileInstance.save()) {
            flash.message = "Profile ${profileInstance.id} created"
            redirect(action:show,id:profileInstance.id)
        }
        else {
            render(view:'create',model:[profileInstance:profileInstance])
        }
    }
}
