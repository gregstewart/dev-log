<cfapplication name="#right(REReplace(expandPath('.'),'[^A-Za-z]','','all'),64)#" sessionmanagement="yes" />
<cfsetting requestTimeOut = "240">
<cfinclude template="/fb5/fusebox5.cfm" />
