<?xml version="1.0" encoding="UTF-8"?>
<!--
Name : Send_Email_with_ErrorDetails.xsl
Author :py1773
Created Date :01-Nov-2014
Desctipstion :This would send an email to the Distribution List Configured
	-->

<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:fo="http://www.w3.org/1999/XSL/Format"
											xmlns:xs="http://www.w3.org/2001/XMLSchema" 
											xmlns:fn="http://www.w3.org/2005/xpath-functions"
											xmlns:dp  ="http://www.datapower.com/extensions" 
											xmlns:dpconfig="http://www.datapower.com/param/config" exclude-result-prefixes="dp dpconfig" extension-element-prefixes="dp"
											xmlns:mime="urn:iso:identified-organization:dod:internet:mail:mixer">

<xsl:output method="html"/>

<xsl:template match="/">

           <!-- get the HTML data to be sent -->
        <xsl:variable name="unSerializedHTMLData">
            <xsl:copy-of select="."/>
        </xsl:variable>
		
        <!--
            Call the dp:serialize function to serialize the HTML data to be sent, thus generating an escaped version of the data. Also, set the 'omit-xml-decl' attribute of the dp:serialize function to "yes". This will cause the XML declaration not to be included in the output produced.
        -->
        <xsl:variable name="serializedHTMLData">
            <dp:serialize select="$unSerializedHTMLData"
                omit-xml-decl="yes"/>
        </xsl:variable>

        <!--
            Construct the complete email data to send as follows:
            content-type: text/html\r\n\r\n <html><b>Test</b></html>
        -->
        <xsl:variable name="htmlData">content-type: text/html&#x0D;&#x0A;&#x0D;&#x0A;
            <xsl:copy-of select="$serializedHTMLData"/>
        </xsl:variable>

        <!-- base-64 encode the HTML data to be sent -->
        <xsl:variable name="encodedHTMLData"
            select="dp:encode($htmlData,'base-64')"/>

        <!--
            Set the target SMTP url, specify the data-type as "base64", and send the base-64 encoded HTML data. The recipient of this mail will receive "Test" in bold.
        -->
		<xsl:variable name="XPathConstantsDoc" select="document('local:///Spinco/Framework/Data/SpincoPath.xml')"/>

		<xsl:variable name="FrameworkDataFolderXPath">
			<xsl:for-each select="$XPathConstantsDoc/SpincoPath/Key[Name='FrameworkData']">
				<xsl:value-of select="ValuePath"/>
			</xsl:for-each>
		</xsl:variable>

		<xsl:variable name="DataFolderXPath">
			<xsl:for-each select="$XPathConstantsDoc/SpincoPath/Key[Name='Data']">
				<xsl:value-of select="ValuePath"/>
			</xsl:for-each>
		</xsl:variable>

		<xsl:variable name="FileConcat">
			<xsl:value-of select="concat($FrameworkDataFolderXPath,'ErrorIdentification.xml')"/>
		</xsl:variable>

		<xsl:variable name="ErrorIdentificationDoc" select="document($FileConcat)"/>
				
		<xsl:variable name="MsgSender">
			<xsl:value-of select="$ErrorIdentificationDoc/EmailIdentification/EmailDetails/Header/Sender/text()"/>
		</xsl:variable>
		
		<xsl:variable name="MsgRecipient">
			<xsl:value-of select="$ErrorIdentificationDoc/EmailIdentification/EmailDetails/Header/Receiver/text()"/>
		</xsl:variable>

		<xsl:variable name="MsgSubject" select="dp:variable('var://context/var/DynamicSubject')"/>
		
		<xsl:variable name="EmailServer">
			<xsl:value-of select="$ErrorIdentificationDoc/EmailIdentification/EmailDetails/Header/Server/text()"/>
		</xsl:variable>
		
		<!-- URL encode the values before building the url-open function -->
        <xsl:variable name="EncSender" select="dp:encode($MsgSender,'URL')"/>
        <xsl:variable name="EncRecipient" select="dp:encode($MsgRecipient,'URL')"/>
        <xsl:variable name="EncSubject" select="dp:encode($MsgSubject,'URL')"/>

       <xsl:variable name="smtpURL">dpsmtp://<xsl:value-of select="$EmailServer"/>/?MIME=true&amp;To=<xsl:value-of select="$EncRecipient"/>&amp;From=<xsl:value-of select="$EncSender"/>&amp;Subject=<xsl:value-of select="$EncSubject"/></xsl:variable> 
		 
		 <dp:url-open target="{$smtpURL}" response="ignore" data-type="base64">
		  <xsl:copy-of select="$encodedHTMLData" /> 
		 </dp:url-open>
		 
	<xsl:copy-of select="."/>
 </xsl:template>
    
</xsl:stylesheet>

