<xsl:transform 
   version="1.0" 
   xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
   xmlns:fn="http://www.w3.org/2005/xpath-functions"
><xsl:template match="base-object">return {
<xsl:for-each select="*"><xsl:choose>
		<xsl:when test="name(.) = 'attributes' or name(.) = 'build-flags' or name(.) = 'order-flags'"><xsl:call-template name="flags"/></xsl:when>
		<xsl:when test="name(.) = 'weapon'"><!--PASS--></xsl:when>
		<xsl:when test="name(.) = 'action'"><!--PASS--></xsl:when>
		<xsl:when test="name(.) = 'device'"><xsl:call-template name="device"/></xsl:when>
		<xsl:when test="name(.) = 'rotation'"><xsl:call-template name="rotation"/></xsl:when>
		<xsl:otherwise><xsl:call-template name="plain"/></xsl:otherwise>
	</xsl:choose>
</xsl:for-each>
<xsl:if test="action">
		["action"] = {
		<xsl:for-each select="action">
			[<xsl:number/>] = {
				["id"] = <xsl:value-of select="@id"/>;
				["count"] = <xsl:value-of select="@count"/>;
				["trigger"] = <xsl:value-of select="@trigger"/>;
			};
		</xsl:for-each>
		};
	</xsl:if>
	
	<xsl:if test="weapon">
		["weapon"] = {
		<xsl:for-each select="weapon">
		[<xsl:number/>] = {
			["id"] = <xsl:value-of select="@id"/>;
			["type"] = <xsl:value-of select="@type"/>;
			["position"] = {
				<xsl:for-each select="position">[<xsl:number/>] = {
					["x"] = <xsl:value-of select="@x"/>;
					["y"] = <xsl:value-of select="@y"/>;
					};</xsl:for-each>
			};
		};
		</xsl:for-each>
	};
	</xsl:if>
}</xsl:template>
<xsl:template name="flags">
["<xsl:value-of select="name(.)"/>"] = {
<xsl:for-each select="*">["<xsl:value-of select="name(.)"/>"] = true;</xsl:for-each>
};
</xsl:template>
<xsl:template name="device">
["device"] = {<xsl:for-each select="*">
<xsl:call-template name="plain"/>
</xsl:for-each>
};</xsl:template>
<xsl:template name="rotation">
["rotation"] = {<xsl:for-each select="*">
<xsl:call-template name="plain"/>
</xsl:for-each>};
</xsl:template>
<xsl:template name="plain">
["<xsl:value-of select="name(.)"/>"] = <xsl:choose>
<xsl:when test="@real"><xsl:value-of select="@real"/></xsl:when>
<xsl:when test="@integer"><xsl:value-of select="@integer"/></xsl:when>
<xsl:when test="@string">"<xsl:value-of select="@string"/>"</xsl:when>
</xsl:choose>;
</xsl:template>
<xsl:template match="other">
</xsl:template>
</xsl:transform>

