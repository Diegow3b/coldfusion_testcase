<!--- ******************************************************
*   Programado por : Diego                                 *
*   Criado em      : 29-06-2018                            *
******************************************************* --->
<cfcomponent hint="TesteCase - API" name="tec_api">

    <!--- Inicializador do Componente --->
    <cffunction name="init" type="array">
        <cfset res_arr=arrayNew(1)>
        <cfset ts1_arr=arrayNew(1)>
        <cfset ts2_arr=arrayNew(1)>

        <!--- URL to be tested --->
        <!--- FIRST 3 will be 200, lasts one will be 403 --->
        <cfset BasUrl = [
            "https://www.mocky.io/v2/5185415ba171ea3a00704eed",
            "http://www.mocky.io/v2/5b369511340000200bf88a3a",
            "http://www.mocky.io/v2/5b369532340000f60cf88a3c",
            "http://www.mocky.io/v2/5b369540340000200bf88a3e",
            "http://www.mocky.io/v2/5b369597340000730df88a3f",
            "http://www.mocky.io/v2/5b3695ce3400002d0df88a40",
            "http://www.mocky.io/v2/5b3695d8340000730df88a42"
        ]>

        <cfoutput>
            <cfloop array="#BasUrl#" index="sig_url">
                <!---Test Acess to API - method: GET --->
                #thePageAccessShouldBeValid(sig_url)#
                #thePageAccessShouldBeThrow403(sig_url)#
            </cfloop>

            #compileArrays()#
        </cfoutput>
        <!--- Returning Array with all Results --->

        <cfreturn res_arr>
    </cffunction>

    <cffunction name="compileArrays" access="private" type="void">
        <cfset #arrayAppend(res_arr, ts1_arr)#>
        <cfset #arrayAppend(res_arr, ts2_arr)#>
    </cffunction>
    
    <cffunction name="thePageAccessShouldBeThrow403" access="private" type="void">
        <cfargument name="BasUrl" type="string">
        
        <cfset fun_pas=structNew()>
        <cfset spl_url = listToArray(BasUrl.Replace("/", ",", "All"))>
        <cfset fun_pas.url=BasUrl>
        <cfset fun_pas.mol=spl_url[2]>
        <cfset fun_pas.fil=spl_url[3]>
        
        <cfset fun_pas.fun="thePageAccessShouldBeThrow403">
         
        <cfhttp url="#BasUrl#" result="res" method="GET">
            
        <cfset exp="403 Forbidden">
        <cfset act="#res.Statuscode#">        
        
        <cfset fun_pas.res = ((exp EQ act) ? "Success" : "Failed") />

        <cfset #arrayAppend(ts1_arr, fun_pas)#>
    </cffunction>

    <cffunction name="thePageAccessShouldBeValid" access="private" type="void">
        <cfargument name="BasUrl" type="string">

        <cfset fun_pas=structNew()>
        <cfset spl_url = listToArray(BasUrl.Replace("/", ",", "All"))>
        <cfset fun_pas.mol=spl_url[2]>
        <cfset fun_pas.fil=spl_url[3]>
        <cfset fun_pas.url=BasUrl>
        <cfset fun_pas.fun="thePageAccessShouldBeValid">
    
        <cfhttp url="#BasUrl#" result="res" method="GET">
    
        <cfset exp="200 OK">
        <cfset act="#res.Statuscode#">        
        
        <cfset fun_pas.res = ((exp EQ act) ? "Success" : "Failed") />

        <cfset #arrayAppend(ts2_arr, fun_pas)#>
        
        <!--- <cfset assertEquals(exp,act, "Link indisponivel")> --->
    </cffunction>
    
</cfcomponent>
