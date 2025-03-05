/* eslint-disable @typescript-eslint/no-use-before-define, @typescript-eslint/no-unused-expressions */
import React, {
  Children,
  cloneElement,
  isValidElement,
  PropsWithChildren,
  ReactNode,
  useEffect,
  useMemo,
  useRef,
  useState,
  useCallback,
} from "react";
import { createPortal } from "react-dom";
import styled from "styled-components";
import { MenuItem } from "./MenuItem";

export enum Behaviour {
  SINGLE,
  MULTIPLE,
}

type CommonProps = {
  label: ReactNode;
};

type SingleProps<TItem = any> = {
  behaviour: Behaviour.SINGLE;
  value?: TItem;
  onChange(item: TItem): void;
} & CommonProps;

type MultipleProps<TItem = any> = {
  behaviour: Behaviour.MULTIPLE;
  value: TItem[];
  onChange(items: TItem[]): void;
} & CommonProps;

type Props<TItem> = SingleProps<TItem> | MultipleProps<TItem>;

type Coords = {
  left: number;
  top: number;
  width: number;
};

export const Dropdown = <T extends unknown>(
  props: PropsWithChildren<Props<T>>
) => {
  const { label, children } = props;
  const [isOpen, setOpen] = useState(false);
  const [highlightedIndex, setHighlightedIndex] = useState(-1);
  const elements = useRef<Record<number, HTMLDivElement>>({});
  const controlRef = useRef<HTMLButtonElement>(null);
  const [coords, setCoords] = useState<Coords | null>(null);
  const items = useMemo(() => Children.toArray(children), [children]);

  const indexes = useMemo(
    () =>
      items.reduce<Array<number>>((result, item, index) => {
        if (React.isValidElement(item)) {
          if (item.props.disabled !== true && item.type === MenuItem) {
            result.push(index);
          }
        }

        return result;
      }, []),
    [items]
  );

  const handleOpen = () => setOpen(true);

  const handleChange = useCallback(
    (item: T) => {
      switch (props.behaviour) {
        case Behaviour.SINGLE: {
          props.onChange(item);
          setOpen(false);
          break;
        }
        case Behaviour.MULTIPLE: {
          props.value.includes(item)
            ? props.onChange(props.value.filter((value) => value !== item))
            : props.onChange([...props.value, item]);
          break;
        }
      }
    },
    [props]
  );

  const handleKeyDown = useCallback(
    async (ev: KeyboardEvent) => {
      switch (ev.code) {
        case "ArrowDown":
          ev.preventDefault();
          ev.stopPropagation();
          setHighlightedIndex((highlightedIndex) => {
            const index =
              highlightedIndex === indexes.length - 1
                ? 0
                : highlightedIndex + 1;
            elements.current[indexes[index]]?.scrollIntoView({
              block: "nearest",
            });
            return index;
          });
          break;
        case "ArrowUp": {
          ev.preventDefault();
          ev.stopPropagation();
          setHighlightedIndex((highlightedIndex) => {
            const index =
              highlightedIndex === 0
                ? indexes.length - 1
                : highlightedIndex - 1;
            elements.current[indexes[index]]?.scrollIntoView({
              block: "nearest",
            });
            return index;
          });
          break;
        }
        case "Enter": {
          ev.preventDefault();
          ev.stopPropagation();
          const item = items[indexes[highlightedIndex]];
          if (highlightedIndex !== -1 && isValidElement(item)) {
            handleChange(item.props.value);
            setOpen(false);
          }
          break;
        }
      }
    },
    [handleChange, highlightedIndex, indexes, items]
  );

  const getCoords = (): Coords | null => {
    const box = controlRef.current?.getBoundingClientRect();

    if (box) {
      return {
        left: box.left,
        top: box.top + box.height,
        width: box.width,
      };
    }

    return null;
  };

  useEffect(() => {
    if (!isOpen) return;

    const coords = getCoords();
    setCoords(coords);
  }, [isOpen]);

  useEffect(() => {
    if (isOpen) {
      document.addEventListener("keydown", handleKeyDown, true);
    }

    return () => {
      document.removeEventListener("keydown", handleKeyDown, true);
    };
  }, [isOpen, handleKeyDown]);

  return (
    <Root>
      <Control ref={controlRef} onClick={handleOpen} type="button">
        {label}
      </Control>
      {isOpen &&
        coords &&
        createPortal(
          <>
            <Backdrop onClick={() => setOpen(false)} />
            <Menu coords={coords}>
              {Children.map(children, (child, index) => {
                if (isValidElement(child)) {
                  return cloneElement(child, {
                    active: index === indexes[highlightedIndex],
                    onMouseEnter: () =>
                      setHighlightedIndex(indexes.indexOf(index)),
                    onClick: (ev: MouseEvent) => {
                      ev.stopPropagation();
                      !child.props.disabled && handleChange(child.props.value);
                    },
                    ref: (node: HTMLDivElement) =>
                      (elements.current[index] = node),
                  });
                }
              })}
            </Menu>
          </>,
          document.body
        )}
    </Root>
  );
};

Dropdown.MenuItem = MenuItem;

const Root = styled.div``;

const Control = styled.button`
  padding: 0;
  margin: 0;
  border: none;
  background-color: #88B5CE;
`;

const Menu = styled.menu<{ coords: Coords }>`
  position: absolute;
  left: ${(p) => `${p.coords.left}px`};
  top: ${(p) => `${p.coords.top}px`};
  min-width: ${(p) => `${Math.max(100, p.coords.width)}px`};
  margin: 1px 0 0;
  padding: 0;
  border: 1px solid #88B5CE;
  max-height: 300px;
  overflow-y: auto;
  background-color: #88B5CE;
  border-radius: 3px;
 `;

const Backdrop = styled.div`
  position: fixed;
  inset: 0;
`;
