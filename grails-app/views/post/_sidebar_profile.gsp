<div id="sidebar">

        <h3>Profile</h3>

            <dl>
                <dt>User</dt>
                <dd>
                  <%-- TODO Add username and 'sign out' link --%>
                  <sec:username /> (<g:link controller="logout">sign out</g:link>)
                </dd>
            </dl>

        <h3>Mates</h3>
        
            <!-- People I am following -->
            
            <div id="friendsThumbnails">
                JAi shree ram %{--<g:each var="followUser" in="${user.following.sort { it.username } }">
                    <g:link controller="post" action="personal" params="[username: followUser.username]">
                    <img src="${createLink(action: 'tiny', controller: 'image', id: followUser.username)}" alt="${followUser.username}"/>
                    </g:link>
                </g:each>--}%
            </div>
</div>
