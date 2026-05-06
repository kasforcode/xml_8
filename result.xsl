<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
    <xsl:output method="html" encoding="UTF-8"/>
    <xsl:key name="byCity"      match="item" use="@city"/>
    <xsl:key name="byCompany"    match="item" use="concat(@city, '|', @org)"/>
    <xsl:template match="/">
        <html>
            <head>
                <meta http-equiv="Content-Type" content="text/html; charset=UTF-8"/>
                <title>Города</title>
            </head>
            <body>
                <h1>Города и компании</h1>
                <ul>
                    <xsl:for-each select="orgs/item[generate-id(.) = generate-id(key('byCity', @city)[1])]">
                        <xsl:sort select="@city"/>
                        <li>
                            <h3><xsl:value-of select="@city"/></h3>
                            <p>Всего товаров: <xsl:value-of select="count(key('byCity', @city))"/></p>
                            <ul>
                                <xsl:for-each select="key('byCity', @city)[generate-id(.) = generate-id(key('byCompany', concat(@city, '|', @org))[1])]">
                                    <xsl:sort select="@org"/>
                                    <li>
                                        <h4><xsl:value-of select="@org"/></h4>
                                        <p>Всего товаров: <xsl:value-of select="count(key('byCompany', concat(@city, '|', @org)))"/></p>
                                        <ul>
                                            <xsl:for-each select="key('byCompany', concat(@city, '|', @org))">
                                                <xsl:sort select="@title"/>
                                                <li><xsl:value-of select="@title"/></li>
                                            </xsl:for-each>
                                        </ul>
                                    </li>
                                </xsl:for-each>
                            </ul>
                        </li>
                    </xsl:for-each>
                </ul>
            </body>
        </html>
    </xsl:template>
</xsl:stylesheet>
