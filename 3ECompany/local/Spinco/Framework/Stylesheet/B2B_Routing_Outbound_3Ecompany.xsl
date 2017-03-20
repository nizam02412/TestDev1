<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0" xmlns:dp="http://www.datapower.com/extensions" xmlns:dpconfig="http://www.datapower.com/param/config" xmlns:regexp="http://exslt.org/regular-expressions" xmlns:date="http://exslt.org/dates-and-times" extension-element-prefixes="dp regexp" exclude-result-prefixes="dp regexp dpconfig">
	<xsl:template match="/">
		<xsl:variable name="protocol" select="dp:variable('var://service/protocol')"/>
		<xsl:choose>
			<xsl:when test="$protocol='dpmqfte'">
				<!-- Get the MQRFH2 headers -->
				<xsl:variable name="MQRFH2" select="dp:request-header('MQRFH2')"/>
				<!-- Parse the MQRFH2 headers to XML format -->
				<xsl:variable name="parsedMQRFH2" select="dp:parse($MQRFH2)"/>
				
				<xsl:variable name="FTEFileName">
					<xsl:value-of select="$parsedMQRFH2//WMQFTEFileName"/>
				</xsl:variable>
				
				<xsl:variable name="FileName" select="regexp:match($FTEFileName, '([^\/]*)$')"/>
				
				<xsl:variable name="DPFileName">
					<xsl:value-of select="$parsedMQRFH2//FileName"/>
				</xsl:variable>

				<xsl:variable name="FolderName">
					<xsl:value-of select="$parsedMQRFH2//Directory"/>
				</xsl:variable>

				<xsl:variable name="XPathConstantsDoc" select="document('local:///Spinco/Framework/Data/SpincoPath.xml')"/>

				<xsl:variable name="FrameworkDataFolderXPath">
					<xsl:for-each select="$XPathConstantsDoc/SpincoPath/Key[Name='FrameworkData']">
						<xsl:value-of select="ValuePath"/>
					</xsl:for-each>
				</xsl:variable>

				<xsl:variable name="InterfaceNameXPath">
					<xsl:for-each select="$XPathConstantsDoc/SpincoPath/Key[Name='Interface']">
						<xsl:value-of select="ValuePath"/>
					</xsl:for-each>
				</xsl:variable>

				<xsl:variable name="DataFolderXPath">
					<xsl:for-each select="$XPathConstantsDoc/SpincoPath/Key[Name='Data']">
						<xsl:value-of select="ValuePath"/>
					</xsl:for-each>
				</xsl:variable>

				<xsl:variable name="FileConcat">
					<xsl:value-of select="concat($FrameworkDataFolderXPath,'OutboundFileIdentification.xml')"/>
				</xsl:variable>

				<xsl:variable name="OutboundFileIdentificationXPath" select="document($FileConcat)"/>
				
				<xsl:variable name="Sender">
					<xsl:for-each select="$OutboundFileIdentificationXPath/OutboundFileIdentification/System[@FolderName=$FolderName]/Message[FileName=$DPFileName]">
						<xsl:value-of select="Sender"/>
					</xsl:for-each>
				</xsl:variable>
				
				<xsl:variable name="Receiver">
					<xsl:for-each select="$OutboundFileIdentificationXPath/OutboundFileIdentification/System[@FolderName=$FolderName]/Message[FileName=$DPFileName]">
						<xsl:value-of select="Receiver"/>
					</xsl:for-each>
				</xsl:variable>

				<xsl:variable name="InterfaceName">
					<xsl:for-each select="$OutboundFileIdentificationXPath/OutboundFileIdentification/System[@FolderName=$FolderName]/Message[FileName=$DPFileName]">
						<xsl:value-of select="InterfaceName"/>
					</xsl:for-each>
				</xsl:variable>

				<xsl:variable name="InterfaceNumber">
					<xsl:for-each select="$OutboundFileIdentificationXPath/OutboundFileIdentification/System[@FolderName=$FolderName]/Message[FileName=$DPFileName]">
						<xsl:value-of select="InterfaceNumber"/>
					</xsl:for-each>
				</xsl:variable>

				<xsl:variable name="InterfaceMetaData" select="document(concat($InterfaceNameXPath,$InterfaceName,$DataFolderXPath,'InterfaceMetaData.xml'))"/>

				<xsl:variable name="SFTPFolder">
					<xsl:value-of select="$InterfaceMetaData/InterfaceMetaData/System[@Name = $Receiver]/Channel/Url/text()"/>
				</xsl:variable>

				<dp:set-variable name="'var://service/b2b-partner-from'" value="$Sender"/>
				<dp:set-variable name="'var://service/b2b-partner-to'" value="$Receiver"/>

				<xsl:variable name="SFTPDestination">
					<xsl:value-of select="concat($SFTPFolder,$FileName)"/>
				</xsl:variable>
	
				<xsl:variable name="url_to_route" select="$SFTPDestination"/>

				<dp:set-variable name="'var://service/URI'" value="$url_to_route"/>

				<xsl:copy-of select="."/>

			</xsl:when>

		</xsl:choose>

	</xsl:template>
</xsl:stylesheet>
