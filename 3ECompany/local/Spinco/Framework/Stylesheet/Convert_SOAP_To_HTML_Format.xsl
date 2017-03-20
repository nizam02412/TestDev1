<?xml version="1.0" encoding="UTF-8"?>
<!--
Name :Convert_SOAP_To_HTML_Format.xsl
Author : py1773
Created Date : 01-Nov-2014
Desctipstion : This XSL would convert the SOAP Request Received From the log Target to HTML format to be sent as an email to the Distribution List
	-->

<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0" 
						xmlns:dp="http://www.datapower.com/extensions" 
						xmlns:dpconfig="http://www.datapower.com/param/config" exclude-result-prefixes="dp dpconfig" extension-element-prefixes="dp"
						xmlns:SOAP-ENV="http://schemas.xmlsoap.org/soap/envelope/">
						
	<xsl:output method="xml" omit-xml-declaration="yes"/>
	
	
<!--<SOAP-ENV:Envelope xmlns:SOAP-ENV="http://schemas.xmlsoap.org/soap/envelope/">
		<SOAP-ENV:Body>
				<log-entry domain="Dev1_HR" serial="17">
						<date>Fri Oct 17 2014</date>
						<time utc="1413542797694">06:46:37</time>
						<date-time>2014-10-17T06:46:37</date-time>
						<type>mq</type>
						<class>mq-qm</class>
						<object>DEV1_QM_FTE_BKP</object>
						<level num="3">error</level>
						 <transaction-type/>
						<transaction>1244527</transaction>
						<client/>
						<code>0x80e00107</code>
						<file/>
						<message>Queue Manager Error: '10.2.66.72(1420)' 'QMAGTRAD01'. Reason code - 2059</message>
				 </log-entry>
		</SOAP-ENV:Body>
</SOAP-ENV:Envelope>-->

	<xsl:template match="/">
	
			<html>
				<body>
					<h2>Datapower Alert Detail</h2>
					<table border="3">
					<tr>
						<th>Domain Name</th>
						<td><xsl:value-of select="SOAP-ENV:Envelope/SOAP-ENV:Body/log-entry/@domain"/></td>
					 </tr>  
					 <tr>
						<th>Date</th>
						<td><xsl:value-of select="SOAP-ENV:Envelope/SOAP-ENV:Body/log-entry/date/text()"/></td>
					 </tr>  
					 <tr>
						<th>Time</th>
						<td><xsl:value-of select="SOAP-ENV:Envelope/SOAP-ENV:Body/log-entry/date-time/text()"/></td>
					 </tr>  
					 <tr>
						<th>Error Type</th>
						<td><xsl:value-of select="SOAP-ENV:Envelope/SOAP-ENV:Body/log-entry/type/text()"/></td>
					 </tr>  
					 <tr>
						<th>Error Class</th>
						<td><xsl:value-of select="SOAP-ENV:Envelope/SOAP-ENV:Body/log-entry/class/text()"/></td>
					 </tr>  
					 <tr>
						<th>Object Name</th>
						<td><xsl:value-of select="SOAP-ENV:Envelope/SOAP-ENV:Body/log-entry/object/text()"/></td>
					 </tr>  
					 <tr>
						<th>Alert Level</th>
						<td><xsl:value-of select="SOAP-ENV:Envelope/SOAP-ENV:Body/log-entry/level/text()"/></td>
					 </tr>  
					 <tr>
						<th>Transaction Type</th>
						<td><xsl:value-of select="SOAP-ENV:Envelope/SOAP-ENV:Body/log-entry/transaction-type/text()"/></td>
					 </tr>  
					 <tr>
						<th>Transaction ID</th>
						<td><xsl:value-of select="SOAP-ENV:Envelope/SOAP-ENV:Body/log-entry/transaction/text()"/></td>
					 </tr>  
					 <tr>
						<th>Error Code</th>
						<td><xsl:value-of select="SOAP-ENV:Envelope/SOAP-ENV:Body/log-entry/code/text()"/></td>
					 </tr>
					  <tr>
						<th>File</th>
						<td><xsl:value-of select="SOAP-ENV:Envelope/SOAP-ENV:Body/log-entry/file/text()"/></td>
					 </tr>
					 <tr>
						<th>Error Details</th>
						<td><xsl:value-of select="SOAP-ENV:Envelope/SOAP-ENV:Body/log-entry/message/text()"/></td>
					 </tr>
					</table>
				</body>
			</html>
			<xsl:variable name="DomainName"><xsl:value-of select="SOAP-ENV:Envelope/SOAP-ENV:Body/log-entry/@domain"/></xsl:variable>
			<dp:set-variable name="'var://context/var/DynamicSubject'" value="$DomainName"/>
	</xsl:template>
</xsl:stylesheet>
