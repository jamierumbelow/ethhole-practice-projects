import React from "react";
import { PageHeader } from "antd";

// displays a page header

export default function Header() {
  return (
    <PageHeader
      title="The Big Ad Page"
      subTitle="advertising space powered by Ethereum"
      style={{ cursor: "pointer" }}
    />
  );
}
