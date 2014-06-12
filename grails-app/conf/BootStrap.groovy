import com.newrelic.user.Post
import com.newrelic.user.Profile
import com.newrelic.user.Role
import com.newrelic.user.Tag
import com.newrelic.user.User
import com.newrelic.user.UserRole
import org.example.*

class BootStrap {
    def springSecurityService

    def init = { servletContext ->
        def samples = [
                'chuck_norris' : [ fullName: 'Chuck Norris', email: "chuck@example.org" ],
                'glen' : [ fullName: 'Glen Smith', email: "glen@example.org" ],
                'peter' : [ fullName: 'Peter Ledbrook', email: "peter@somewhere.net" ],
                'sven' : [ fullName: 'Sven Haiges', email: "sven@example.org" ],
                'burt' : [fullName : 'Burt Beckwith', email: "burt@somewhere.net" ] ]

        def now = new Date()
        def random = new Random()

        def userRole = getOrCreateRole("ROLE_USER")
        def adminRole = getOrCreateRole("ROLE_ADMIN")

        def users = User.list() ?: []
        if (!users) {
            // Start with the admin user.
            def adminUser = new User(
                    username: "admin",
                    password:"s3cur3",
                    enabled: true).save()
            UserRole.create adminUser, adminRole

            // Now the normal users.
            samples.each { username, profileAttrs ->
                def user = new User(
                        username: username,
                        password: "password",
                        enabled: true)
                if (user.validate()) {
                    println "Creating user ${username}..."
                    user.profile = new Profile(profileAttrs)
                    def url = this.class.getResource("/${username}.jpg")
                    if (url) {
                        def image = new File(url.toURI()).readBytes()
                        println "Creating With custom photo"
                        user.profile.portrait = image
                    }

                    user.addToPosts(content: "My first post!", createdOn: now - random.nextInt(4))
                    user.addToPosts(content: "I'm completing my exercises", createdOn: now - random.nextInt(4))
                    user.save(flush:true)

                    def rel = UserRole.create(user, userRole)
                    if (rel.hasErrors()) println "Failed to assign user role to ${user.username}: ${rel.errors}"

                    users << user
                }
                else {
                    println("\n\n\nError in account bootstrap for ${username}!\n\n\n")
                    user.errors.each {err ->
                        println err
                    }
                }
            }
        }

        users[0].addToFollowing(users[1])
        users[0].addToFollowing(users[2])
        users[0].addToFollowing(users[4])
        users[0].save()
        users[2].addToFollowing(users[0])
        users[2].addToFollowing(users[3])
        users[2].save(flush: true)

        // Some tags as well.
        def grailsTag = new Tag(label: "grails")
        def groovyTag = new Tag(label: "groovy")
        def javaTag = new Tag(label: "java")

        def posts = Post.list()
        posts[0].addToTags(grailsTag)
        posts[0].addToTags(groovyTag)
        posts[0].save()
        posts[3].addToTags(grailsTag)
        posts[3].addToTags(javaTag)
        posts[3].save()
        posts[6].addToTags(javaTag)
        posts[6].save()
        posts[7].addToTags(javaTag)
        posts[7].save()
    }

    def destroy = {
    }

    private getOrCreateRole(name) {
        def role = Role.findByAuthority(name)
        if (!role) role = new Role(authority: name).save()
        if (!role)  println "Unable to save role ${name}"
        return role
    }
} 
