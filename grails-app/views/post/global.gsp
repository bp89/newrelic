<html>
    <head>
        <title>Global Timeline</title>
    </head>
    <body>

	<!--	
        <h3>
            Global Timeline
        </h3>
	-->

        <g:if test="${user}">
            <g:render template="newpost" model="[user: user]"/>
        </g:if>

        <div id="firstPost"></div>
        <g:render template="postentries" collection="${posts}" />

        <g:paginate total="${postCount}"/>

    </body>
</html>
