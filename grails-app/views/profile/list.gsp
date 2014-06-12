
<%@ page import="org.example.Profile" %>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8"/>
        <meta name="layout" content="main" />
        <title>Profile List</title>
    </head>
    <body>
        <div class="nav">
            <span class="menuButton"><a class="home" href="${resource(dir:'')}">Home</a></span>
            <span class="menuButton"><g:link class="create" action="create">New Profile</g:link></span>
        </div>
        <div class="body">
            <h1>Profile List</h1>
            <g:if test="${flash.message}">
            <div class="message">${flash.message}</div>
            </g:if>
            <div class="list">
                <table>
                    <thead>
                        <tr>
                        
                   	        <g:sortableColumn property="id" title="Id" />
                        
                   	        <g:sortableColumn property="fullName" title="Full Name" />
                        
                   	        <g:sortableColumn property="email" title="Email" />
                        
                   	        <g:sortableColumn property="portrait" title="Portrait" />
                        
                   	        <th>User</th>
                   	    
                        </tr>
                    </thead>
                    <tbody>
                    <g:each in="${profileInstanceList}" status="i" var="profileInstance">
                        <tr class="${(i % 2) == 0 ? 'odd' : 'even'}">
                        
                            <td><g:link action="show" id="${profileInstance.id}">${fieldValue(bean:profileInstance, field:'id')}</g:link></td>
                        
                            <td>${fieldValue(bean:profileInstance, field:'fullName')}</td>
                        
                            <td>${fieldValue(bean:profileInstance, field:'email')}</td>
                        
                            <td>${fieldValue(bean:profileInstance, field:'portrait')}</td>
                        
                            <td>${fieldValue(bean:profileInstance, field:'user')}</td>
                        
                        </tr>
                    </g:each>
                    </tbody>
                </table>
            </div>
            <div class="paginateButtons">
                <g:paginate total="${profileInstanceTotal}" />
            </div>
        </div>
    </body>
</html>
