import React, { useMemo } from "react";
import { Card } from "antd";
import { useContractLoader, useContractReader } from "../hooks";

const AdDisplay = ({ provider }) => {
  const readContracts = useContractLoader(provider);
  const ctaUrl = useContractReader(readContracts, "Ads", "ctaUrl");
  const imageUrl = useContractReader(readContracts, "Ads", "imageUrl");
  const text = useContractReader(readContracts, "Ads", "text");

  const loading = useMemo(() => !ctaUrl, [readContracts, ctaUrl]);

  return (
    <Card size="large" style={{ marginTop: 25, width: "100%" }} loading={loading}>
      <a href={ctaUrl} style={{ display: "flex", flexDirection: "column" }}>
        <p style={{ width: "25%", textAlign: "center", marginLeft: "auto", marginRight: "auto" }}>
          <img src={imageUrl} alt={text} />
        </p>
        {text}
      </a>
    </Card>
  );
};

export default AdDisplay;
