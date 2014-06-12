<html>
<head>
  <title>Hubbub &raquo; <g:layoutTitle default="Welcome" /></title>
  <link rel="stylesheet" href="${resource(dir: 'css', file: 'hubbub.css')}"/>
  <link rel="shortcut icon" href="${resource(dir: 'images',file: 'favicon.ico')}" type="image/x-icon" />
  <link rel="stylesheet" href="${resource(dir: 'css', file: 'reset-fonts-grids.css')}"/>
  <g:layoutHead />
  <g:javascript library="application" />
  <g:javascript library="scriptaculous"/>
</head>
<body>	
  <div id="doc3" class="yui-t5">
    <div id="hd">
      <a href="<g:createLinkTo dir="/"/>"><img id="logo" src="${createLinkTo(dir: 'images', file: 'headerlogo.png')}" alt="hubbub logo"/></a>
    </div>
    <div id="bd"><!-- start body -->
      <div id="yui-main">
        <div class="yui-b">
          <div class="nav">
            <span class="menuButton"><a class="home" href="${resource(dir:'/')}">Home</a></span>
            <sec:ifAllGranted roles="ROLE_USER">
              <span class="menuButton"><g:link class="create" controller="post" action="timeline">My Timeline</g:link></span>
            </sec:ifAllGranted>
            <%--
            <sec:ifNotLoggedIn>
              <span class="menuButton"><g:link controller="login" action="auth">Login</g:link></span>
            </sec:ifNotLoggedIn>
            --%>
          </div>
          <g:if test="${flash.message}">
            <div class="flash">
              ${flash.message}
            </div>
          </g:if>
          <g:layoutBody/>
        </div>
      </div>
      <div class="yui-b">
        <sec:ifNotLoggedIn>
          <g:render template="/post/sidebar_login"/>
        </sec:ifNotLoggedIn>
        <sec:ifLoggedIn>
          <g:render template="/post/sidebar_profile"/>
        </sec:ifLoggedIn>
      </div>
    </div>  <!-- end body -->
    <div id="ft">
      <div id="footerText">
        Hubbub <g:meta name="app.version"/> on Grails <g:meta name="app.grails.version"/>.
      </div>
    </div>
  </div>
  <g:render template="/login/ajaxAuth"/>
</body>	
</html>
