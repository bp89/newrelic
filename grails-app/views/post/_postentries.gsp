<div>
    <div class="postImage">
        <g:if test="${post.user.profile.portrait}">
            <img src="${createLink(controller: 'image', action: 'renderImage', id: post.user.username)}"/>
        </g:if>
    </div>
    <div class="postEntry">
        <div class="postText">

            ${post.user.username}
            ${post.content}

        </div>
        <div class="postDate">
            <h:dateFromNow date="${post.createdOn}"/>
        </div>
    </div>
</div>
