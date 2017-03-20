<?xml version="1.0" encoding="UTF-8"?>
<!--
Name :Convert_XML_To_HTML_Format.xsl
Author : py1773
Created Date : 01-Nov-2014
Desctipstion : This XSL would convert the Error XML received as an SpincoError to HTML format to be sent as an email to the distribution list
	-->

<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0" 
						xmlns:dp="http://www.datapower.com/extensions" 
						xmlns:dpconfig="http://www.datapower.com/param/config" exclude-result-prefixes="dp dpconfig" extension-element-prefixes="dp">
						
	<xsl:output method="xml" omit-xml-declaration="yes"/>
	
<!--	<?xml version="1.0" encoding="UTF-8"?>
--><!--Sample XML file generated by XMLSpy v2014 rel. 2 sp1 (x64) (http://www.altova.com)--><!--
<SpincoError xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xsi:noNamespaceSchemaLocation="SpincoError.xsd">
	<Header>
		<InterfaceNumber>String</InterfaceNumber>
		<InterfaceName>String</InterfaceName>
		<TransactionID>String</TransactionID>
		<DomainName>String</DomainName>
		<ObjectName>String</ObjectName>
		<Sender>String</Sender>
		<Receiver>String</Receiver>
		<Date>String</Date>
		<Time>String</Time>
		<FileName>String</FileName>
		<FolderName>String</FolderName>
		<Message>
			<Type>String</Type>
			<Format>String</Format>
		</Message>
		<AlertLevel>String</AlertLevel>
		<ErrorCode>String</ErrorCode>
		<ErrorDescription>String</ErrorDescription>
	</Header>
	<Payload/>
</SpincoError>-->

	
	<xsl:template match="/">
			<html>
				<body>
					<h2>Datapower Alert Detail</h2>
					<table border="3">
					 <tr> 
						<th>Domain Name</th>
						<td><xsl:value-of select="SpincoError/Header/DomainName"/></td>
					 </tr>
					  <tr> 
						<th>Interface Name</th>
						<!--<td><xsl:value-of select="SpincoError/Header/InterfaceName"/></td>-->
						<xsl:choose>
							<xsl:when test="string-length(SpincoError/Header/InterfaceName) != '0'">
								<td><xsl:value-of select="SpincoError/Header/InterfaceName" /></td>
							</xsl:when>
							<xsl:otherwise>
								<td><xsl:value-of select="'UNKnown'" /></td>
							</xsl:otherwise>
						</xsl:choose>
					 </tr>
					  <tr> 
						<th>Interface Number</th>
						<!--<td><xsl:value-of select="SpincoError/Header/InterfaceNumber"/></td>-->
						<xsl:choose>
							<xsl:when test="string-length(SpincoError/Header/InterfaceNumber) != '0'">
								<td><xsl:value-of select="SpincoError/Header/InterfaceNumber" /></td>
							</xsl:when>
							<xsl:otherwise>
								<td><xsl:value-of select="'UNKnown'" /></td>
							</xsl:otherwise>
						</xsl:choose>
					 </tr>
					  <tr> 
						<th>Object Name</th>
						<td><xsl:value-of select="SpincoError/Header/ObjectName"/></td>
					 </tr>
					  <tr> 
						<th>Transaction ID</th>
						<td><xsl:value-of select="SpincoError/Header/TransactionID"/></td>
					 </tr>
					  <tr> 
						<th>Sender</th>
						<!--<td><xsl:value-of select="SpincoError/Header/Sender"/></td>-->
						<xsl:choose>
							<xsl:when test="string-length(SpincoError/Header/Sender) != '0'">
								<td><xsl:value-of select="SpincoError/Header/Sender" /></td>
							</xsl:when>
							<xsl:otherwise>
								<td><xsl:value-of select="'SDR'" /></td>
							</xsl:otherwise>
						</xsl:choose>
					 </tr>
					  <tr> 
						<th>Receiver</th>
						<!--<td><xsl:value-of select="SpincoError/Header/Receiver"/></td>-->
						<xsl:choose>
							<xsl:when test="string-length(SpincoError/Header/Receiver) != '0'">
								<td><xsl:value-of select="SpincoError/Header/Receiver" /></td>
							</xsl:when>
							<xsl:otherwise>
								<td><xsl:value-of select="'RCVR'" /></td>
							</xsl:otherwise>
						</xsl:choose>
					 </tr>
					 <tr>
						<th>Date</th>
						<td><xsl:value-of select="SpincoError/Header/Date"/></td>
					 </tr>  
					 <tr> 
						<th>Time</th>
						<td><xsl:value-of select="SpincoError/Header/Time"/></td>
					 </tr>
					 <tr> 
						<th>FileName</th>
						<td><xsl:value-of select="SpincoError/Header/FileName"/></td>
					 </tr>
					 <tr> 
						<th>FolderName</th>
						<td><xsl:value-of select="SpincoError/Header/FolderName"/></td>
					 </tr>
					 <tr> 
						<th>Type</th>
						<td><xsl:value-of select="'File'"/></td>
					 </tr>
					 <tr> 
						<th>Format</th>
						<td><xsl:value-of select="'File'"/></td>
					 </tr>
					 <tr> 
						<th>Alert Level</th>
						<td><xsl:value-of select="'High'"/></td>
					 </tr>
					 <tr> 
						<th>Error Code</th>
						<td><xsl:value-of select="SpincoError/Header/ErrorCode"/></td>
					 </tr>
					 <tr> 
						<th>Error Description</th>
						<td><xsl:value-of select="SpincoError/Header/ErrorDescription"/></td>
					 </tr>
					 <tr> 
						<th>Payload</th>
						<td><xsl:value-of select="'NA'"/></td>
					 </tr>
					</table>
				</body>
			</html>
			
			<xsl:variable name="DomainName"><xsl:value-of select="SpincoError/Header/DomainName"/></xsl:variable>
			<xsl:variable name="Sender">
			<xsl:choose>
						<xsl:when test="string-length(SpincoError/Header/Sender) != '0'">
							<xsl:value-of select="SpincoError/Header/Sender" />
						</xsl:when>
						<xsl:otherwise>
							<xsl:value-of select="'SDR'" />
						</xsl:otherwise>
			</xsl:choose>
			</xsl:variable>
			<xsl:variable name="Receiver">
			<xsl:choose>
						<xsl:when test="string-length(SpincoError/Header/Receiver) != '0'">
							<xsl:value-of select="SpincoError/Header/Receiver" />
						</xsl:when>
						<xsl:otherwise>
							<xsl:value-of select="'RCVR'" />
						</xsl:otherwise>
			</xsl:choose>
			</xsl:variable>
			<xsl:variable name="InterfaceNumber">
			<xsl:choose>
						<xsl:when test="string-length(SpincoError/Header/InterfaceNumber) != '0'">
							<xsl:value-of select="SpincoError/Header/InterfaceNumber" />
						</xsl:when>
						<xsl:otherwise>
							<xsl:value-of select="'UNKnown'" />
						</xsl:otherwise>
			</xsl:choose>
			</xsl:variable>
			<xsl:variable name="Subject">
				  <xsl:value-of select="concat($DomainName,'_',$Sender,'_',$Receiver,'_',$InterfaceNumber)" /> 
			</xsl:variable>
			<dp:set-variable name="'var://context/var/DynamicSubject'" value="$Subject"/>
	</xsl:template>
</xsl:stylesheet>