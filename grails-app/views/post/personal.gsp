<html>
    <head>
        <title>Posts for ${person.profile.fullName}</title>
    </head>
    <body>

        <h3>
            Personal Posts for ${person.profile.fullName}
        </h3>

        <div id="following">
            <g:if test="${user && !user.following.contains(person)}">
                <g:remoteLink action="followAjax" id="${person.id}" update="following">Follow this user</g:remoteLink>
            </g:if>
        </div>

        <g:if test="${user && user.id == person.id}">
            <g:render template="newpost" model="[user: user]"/>
        </g:if>
        
        <div id="allPosts">
            <g:render template="postentries" collection="${posts}" />
        </div>

        
        <g:paginate total="${postCount}"/>
        
    </body>
</html>
