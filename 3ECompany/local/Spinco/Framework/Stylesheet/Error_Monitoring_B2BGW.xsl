<?xml version="1.0" encoding="UTF-8"?>
<!--
Name : Error_Monitoring_B2BGW.xsl
Author : py1773
Created Date : 01-Nov-2014
						11 Dec 2014 : Added the Message Expiry to be sent to the Error Queue : py1773
Desctipstion : This is configured with the Internal and External Profiles Business Ids
	-->

<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" 
											xmlns:dp="http://www.datapower.com/extensions" extension-element-prefixes="dp">

<xsl:output method="xml" indent="yes"/>

<xsl:template match="/">
	<xsl:variable name="protocol" select="dp:variable('var://service/protocol')"/>
	<!-- MQRFH2 Configuration Starts -->
		<xsl:variable name="MQMD">
			<xsl:value-of select="dp:request-header('MQMD')" disable-output-escaping="yes"/>
		</xsl:variable>
		
		<xsl:variable name="newMQMD">
			<MQMD>
				<xsl:copy-of select="$MQMD/MQMD/*"/>
				<Format>
					<xsl:value-of select="'MQSTR'"/>
				</Format>
				<Expiry>
					<xsl:value-of select="'5000'"/>
				</Expiry>
			</MQMD>
		</xsl:variable>
		
		<!--Set new MQMD Variable-->
		<xsl:variable name="serializedMQMD">
			<dp:serialize select="$newMQMD"/>
		</xsl:variable>
		
		<dp:set-request-header name="'MQMD'" value="$serializedMQMD"/>
	
		 <xsl:choose>
           <xsl:when test="$protocol='http'">
                <dp:set-variable name="'var://service/b2b-partner-from'"
                                 value="'INTError'"/>
                <dp:set-variable name="'var://service/b2b-partner-to'"
                                 value="'EXTError'"/>
            </xsl:when> 
             <xsl:otherwise>
				 <xsl:value-of select="'Invalid Destination'"/>
			 </xsl:otherwise>
		 </xsl:choose>
		 
		 <xsl:copy-of select="."/>
		 
 </xsl:template>
</xsl:stylesheet>