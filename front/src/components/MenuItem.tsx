import React, { forwardRef, HTMLAttributes, PropsWithChildren } from "react";
import styled from "styled-components";

type Props = {
  active?: boolean;
  disabled?: boolean;
  value: any;
  onClick?(): void;
} & HTMLAttributes<HTMLDivElement>;

export const MenuItem = forwardRef<HTMLDivElement, PropsWithChildren<Props>>(
  (props, ref) => {
    const { active, disabled, children, ...rest } = props;

    return (
      <Root {...rest} ref={ref} disabled={disabled} active={active}>
        {children}
      </Root>
    );
  }
);

const Root = styled.div<{ disabled?: boolean; active?: boolean }>`
  padding: 5px 10px;
  cursor: ${(p) => (p.disabled ? "initial" : "pointer")};
  opacity: ${(p) => (p.disabled ? 0.5 : 1)};
  background-color: ${(p) => (p.active ? "#ececec" : "transparent")};
`;
