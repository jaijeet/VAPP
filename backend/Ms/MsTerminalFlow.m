classdef MsTerminalFlow < MsPotentialFlow
% MSTERMINALFLOW special flow class for flows into terminals of the model from
% the outside world

%==============================================================================
% This file is part of VAPP, the Berkeley Verilog-A Parser and Processor.   
% Author: A. Gokcen Mahmutoglu                                
% Last modified: Thu Aug 25, 2016  10:49AM
%==============================================================================
    properties
        terminal = {};
    end

    methods

        function obj = MsTerminalFlow(terminal)
        % MSTERMINALFLOW
            obj.terminal = terminal;
            obj.node1 = terminal;
            obj.node2 = terminal;

            obj.labelPrefix = 'terminalFlow';
        end

        function out = isExpOut(thisFlow)
        % ISEXPOUT
            % a branch flow is never an explicit out. Only terminal node flows
            % can be explicit outs.
            %
            % Here is how to think about a terminal flow being an explicit
            % output:
            % All terminals have a branch to the reference node. This is
            % because even if they are not connected to the reference node, the
            % module (IrNodeModule) connects them automatically to the
            % reference node with a branch. If they are connected this way
            % (automatically by the module) then this branch will be a twig and
            % its zeroFlow property will be set to true. Otherwise (the
            % terminal node and the reference node connected in the device
            % topology) the branch may be designated as a chord. So it's
            % possible to have a (terminal-reference) branch as a chord. If
            % the branch to the reference node is a chord, however, there must
            % be another twig that connects this terminal node to the rest of
            % the circuit nodes. This branch must exist in the device topology
            % and hence must not be zeroFlow.
            %
            % So: a terminal flow is an explicit output iff we can derive
            % its flow value from the rest of the flows in the device. This is
            % only possible if all the cuts involving that terminal are defined
            % by a zeroFlow twig.
            %
            % We will now consider the two cases laid out above separately.
            % 1. The terminal is connected to the reference node with a
            %    zeroFlow twig. Let's suppose this twig is called "T". Any cut
            %    involving the terminal node other than the one defined by T
            %    itself must encompass T. Hence that cut must include the
            %    reference node as well. Since, when choosing cutsets of nodes,
            %    we always prefer the node set which does not include the
            %    reference node, there will be only one cut that includes the
            %    terminal but not the reference node: T. Since T is zeroFlow,
            %    in this case the terminal is an explicit output.
            %
            % 2. The terminal is connected to the reference node with a twig
            %    that is not zeroFlow. In this case, the terminal flow
            %    cannot be an explicit output. Because the cut defined by that
            %    twig must know the value of the terminal flow in order to
            %    compute the twig flow.
            %
            % 3. The connection between the terminal and the reference node is
            %    a chord: There has to be at least another twig that connects
            %    the terminal to the rest of the device. This twig will not be
            %    zeroFlow. Let's call that twig T. The cut defined by T will
            %    either include the terminal or not. If it does not include the
            %    terminal, that means through this cut we cannot find out the
            %    value of the terminal flow because the terminal is connected
            %    to the reference node (in the cutset defined by T) and would
            %    need the flow value to the reference, node which we never
            %    have.
            %    If the cut defined by T does include the terminal, we have a
            %    non-zeroFlow twig that bridges the cutset to the rest of the
            %    device and hence the terminal flow cannot be an explicit
            %    output.
            %
            % So: the only way a terminal flow can be an explicit output is
            % that it is connected to the reference node with a zeroFlow twig.
            %
            % ADDITION:
            % All of the above is correct. However, there is one special case
            % which has to be handled separately. That case is: A node has only
            % one branch with a non-zero flow and that branch is connected to
            % the reference node. If we handle this case within the general
            % framework, the terminal flow will be an other IO. We could leave
            % it at that but this case appears far too often. Consider a two
            % terminal device with a given I/V characteristic. In this case, we
            % check if the terminal has any twigs other than the one connected
            % to the reference node and mark the terminal flow as an explicit
            % output if the reference twig has a flow contrib.
            
            out = false;
            terminalNode = thisFlow.terminal;

            if thisFlow.isProbe() == false && ...
                                            terminalNode.isReference() == false
                refBranch = terminalNode.getReferenceBranch();
                if refBranch.isTwig() == true 
                    if refBranch.isZeroFlow() == true
                        out = true;
                    elseif terminalNode.hasTwigOtherThan(refBranch) == false
                        % see additional note above
                        refFlow = refBranch.getFlow();
                        if refFlow.isContrib() == true && ...
                                                    refFlow.isProbe() == false
                            out = true;
                        end
                    end
                end

            end
        end

        function terminal = getTerminal(thisFlow)
        % GETTERMINAL
            terminal = thisFlow.terminal;
        end

        function out = isOtherIo(thisFlow)
        % ISOTHERIO
            out = false;
            terminalNode = thisFlow.terminal;
            if terminalNode.isReference() == false
                if thisFlow.isExpOut() == false
                    out = true;
                end
            end
        end

        function out = isIntUnk(thisFlow)
        % ISINTUNK
            % only internal flows can be internal unknowns
            out = false;
        end

        function label = getLabel(thisFlow)
        % GETLABEL
            label = [thisFlow.labelPrefix, '_', thisFlow.terminal.getLabel()];
        end

        function label = getModSpecLabel(thisFlow)
        % GETMODSPECLABEL
        % this has to be augmented with the label of the reference node
            nodeLabel = thisFlow.terminal.getLabel();
            label = ['i', nodeLabel];
        end

        function out = isIndependent(thisFlow)
        % ISINDEPENDENT
            out = thisFlow.isInput();
        end
    % end methods
    end
    
% end classdef
end
