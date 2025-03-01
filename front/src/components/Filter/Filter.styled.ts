import styled from "styled-components";

export const Controls = styled.div`
  display: flex;
  gap: 10px;
  justify-content: center;
`;

export const Label = styled.div`
  border-radius: 3px;
  background-color: "#eee";
  padding: 5px 10px;
`;

export const TagSpan = styled.span<{ color: string }>`
  margin: 0 5px 0 15px;
  position: relative;
  &:before {
    content: "";
    height: 10px;
    width: 10px;
    left: -15px;
    top: 3px;
    background-color: ${(p) => p.color};
    border-radius: 3px;
    position: absolute;
  }
`;