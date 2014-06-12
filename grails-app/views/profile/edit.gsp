
<%@ page import="org.example.Profile" %>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8"/>
        <meta name="layout" content="main" />
        <title>Edit Profile</title>
    </head>
    <body>
        <div class="nav">
            <span class="menuButton"><a class="home" href="${resource(dir:'')}">Home</a></span>
            <span class="menuButton"><g:link class="list" action="list">Profile List</g:link></span>
            <span class="menuButton"><g:link class="create" action="create">New Profile</g:link></span>
        </div>
        <div class="body">
            <h1>Edit Profile</h1>
            <g:if test="${flash.message}">
            <div class="message">${flash.message}</div>
            </g:if>
            <g:hasErrors bean="${profileInstance}">
            <div class="errors">
                <g:renderErrors bean="${profileInstance}" as="list" />
            </div>
            </g:hasErrors>
            <g:form method="post"  enctype="multipart/form-data">
                <input type="hidden" name="id" value="${profileInstance?.id}" />
                <input type="hidden" name="version" value="${profileInstance?.version}" />
                <div class="dialog">
                    <table>
                        <tbody>
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                    <label for="fullName">Full Name:</label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean:profileInstance,field:'fullName','errors')}">
                                    <input type="text" id="fullName" name="fullName" value="${fieldValue(bean:profileInstance,field:'fullName')}"/>
                                </td>
                            </tr> 
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                    <label for="email">Email:</label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean:profileInstance,field:'email','errors')}">
                                    <input type="text" id="email" name="email" value="${fieldValue(bean:profileInstance,field:'email')}"/>
                                </td>
                            </tr> 
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                    <label for="portrait">Portrait:</label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean:profileInstance,field:'portrait','errors')}">
                                    <input type="file" id="portrait" name="portrait" />
                                </td>
                            </tr> 
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                    <label for="user">User:</label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean:profileInstance,field:'user','errors')}">
                                    <g:select optionKey="id" from="${org.'com.newrelic.user'.User.list()}" name="user.id" value="${profileInstance?.user?.id}" ></g:select>
                                </td>
                            </tr> 
                        
                        </tbody>
                    </table>
                </div>
                <div class="buttons">
                    <span class="button"><g:actionSubmit class="save" value="Update" /></span>
                    <span class="button"><g:actionSubmit class="delete" onclick="return confirm('Are you sure?');" value="Delete" /></span>
                </div>
            </g:form>
        </div>
    </body>
</html>
