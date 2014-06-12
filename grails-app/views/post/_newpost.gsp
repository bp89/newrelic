<sec:ifAllGranted roles="ROLE_USER">
<div id="newPost">

    <input id="charLeft" name="charLeft" size="5" value="140" readonly="true"/>

    <h3>
        What is ${user.profile.fullName} hacking on right now?
    </h3>

    <g:if test="${flash.message}">
        <div class="flash">
            ${flash.message}
        </div>
    </g:if>

    <p>
        <g:form action="ajaxAdd">
            <g:textArea id='postContent' name="content" rows="3" cols="50" onkeydown="updateCounter()" /><br/>
            <g:submitToRemote value="Post"
                 url="[controller: 'post', action: 'addPostAjax']"
                 update="[success: 'firstPost']"
                 onSuccess="clearPost(e)"
                 onLoading="showSpinner(true)"
                 onComplete="showSpinner(false)"
                 on401="showLogin();"/>
             <img id="spinner" style="display: none"
                src="<g:createLinkTo dir='/images' file='spinner.gif'/>"/>
        </g:form>

        <g:javascript>
            function clearPost(e) {
                $('postContent').value=''
                updateCounter()
            }
            function showSpinner(visible) {
                $('spinner').style.display = visible ? "inline" : "none"

                if (visible == false) {
                    // Move the child element to after 'firstPost'.
                    var first = $('firstPost')
                    var child = first.firstDescendant().remove()
                    first.insert({after: child})
                }
            }

            function updateCounter() {
                $("charLeft").value = 140 - $F("postContent").length
            }
            
            updateCounter()
        </g:javascript>

    </p>
</div>
</sec:ifAllGranted>
